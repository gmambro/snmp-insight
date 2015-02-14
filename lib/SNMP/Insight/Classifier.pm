package SNMP::Insight::Classifier;

#ABSTRACT: Guess SNMP Agent from description

# Portions based on SNMP::Info.
# Copyright (c) 2003-2012 Max Baker and SNMP::Info Developers
# All rights reserved.

use Moose;
use namespace::autoclean;

#VERSION:

=head1 DESCRIPTION

Autodiscovery of device type applying heuristics on SNMPv2 entities

=cut

use SNMP::Insight 'debug';

=attr device

The instance of L<SNMP::Insight::Device> on which perform device type guessing.

=cut

has device => (
    is  => 'ro',
    isa => 'SNMP::Insight::Device',
);

=attr desc 

A cleaned sysDescr (no new lines nor special characters).

=cut

has desc => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    default => sub {
        my $desc = $_[0]->device->sysDescr or return '';
        $desc =~ s/[\r\n\l]+/ /g;
        return $desc;
    }
);

=method classify

Return a suitable device role for the associated device.

=cut

sub classify {
    my $self = shift;

    my $device = $self->device;

    my $id       = $device->sysObjectID;
    my $vendor   = $device->vendor;
    my $services = $device->sysServices;
    my $desc     = $self->desc;

    SNMP::Insight::debug()
      and print
      "SNMP::Insight::classifier services:$services id:$id sysDescr:\"$desc\" vendor: $vendor\n";

    # Some devices don't implement sysServices, but do return a description.
    # In that case, log a warning and continue.
    if ( !defined($services) && !defined($desc) ) {
        SNMP::Insight::debug() and print "No sysServices nor sysDescr, giving up";
        return;
    }

    my $device_type;

    $device_type = $self->guess_by_desc($desc);
    SNMP::Insight::debug()
      and printf(
        "SNMP::Insight::classifier by description %s\n",
        $device_type || 'undef'
      );

    $device_type ||= $self->guess_by_vendor();
    SNMP::Insight::debug()
      and printf "SNMP::Insight::classifier by vendor %s\n",
      $device_type || 'undef';

    return $device_type;
}

=method guess_by_vendor

Use sysObjectID to guess device type.

=cut

sub guess_by_vendor {
    my $self = shift;

    my $device = $self->device;
    my $id     = $device->sysObjectID;
    my $vendor = $device->vendor;

    # Cisco Small Business (300 500) series override
    # This is for enterprises(1).cisco(9).otherEnterprises(6).ciscosb(1)
    return 'CiscoSB'
      if ( $id =~ /^\.1\.3\.6\.1\.4\.1\.9\.6\.1/ );

    return 'NetSNMP' if $vendor eq 'NetSNMP';
}

=method guess_by_desc

Use sysObjectID to guess device type.

=cut

sub guess_by_desc {
    my $self = shift;

    my $desc = $self->desc;

    return unless $desc =~ /\S/o;

    #------------------------------------------------------------------#
    #                        Cisco Devices                             #
    #------------------------------------------------------------------#

    #  Catalyst 1900
    return 'Cisco::C1900'
      if ( $desc =~ /catalyst/i and $desc =~ /\D19\d{2}/ );

    # Catalyst 2900 and 3500XL (IOS)
    return 'Cisco::C2900'
      if ( $desc =~ /(C2900XL|C2950|C3500XL|C2940|CGESM|CIGESM)/i );

    # Cisco Catalyst 3550 3560
    #   Catalyst 3550 / 3548 Layer2 only switches
    #   Cisco 3400 w/ MetroBase Image
    return 'Cisco::C3550' if $desc =~ /(C3550|C3560|ME340x)/;

    # Cisco 4000-4500
    return 'Cisco::C4000' if $desc =~ /Catalyst 4[05]00/;

    # Cat6k with older SUPs (hybrid CatOS/IOS?)
    return 'Cisco::C6500' if $desc =~ /(c6sup2|c6sup1)/;

    # Cat6k with Sup720, Sup720 or Sup2T (and Sup2 running native IOS?)
    return 'Cisco::C6500'
      if $desc =~ /(s72033_rp|s3223_rp|s32p3_rp|s222_rp|s2t54)/;

    # IOS 15.x on Catalyst 3850
    return 'Cisco::C6500'
      if ( $desc =~ /cisco/i and $desc =~ /CAT3K/ );

    # Cisco 2970
    return 'Cisco::C6500' if ( $desc =~ /(C2970|C2960)/ );

    # Various Cisco blade switches, CBS30x0 and CBS31x0 models
    return 'Cisco::C6500'
      if ( $desc =~ /cisco/i and $desc =~ /CBS3[0-9A-Za-z]{3}/ );

    # Cisco blade switches, CBS30x0 and CBS31x0 models with L2 only
    return 'Cisco::C6500'
      if ( $desc =~ /cisco/i and $desc =~ /CBS3[0-9A-Za-z]{3}/ );

    # Cisco 2970
    return 'Cisco::C6500'
      if ( $desc =~ /(C2970|C2960)/ );

    # Cisco 3750
    return 'Cisco::C6500'
      if ( $desc =~ /cisco/i and $desc =~ /3750/ );

    # Cisco Nexus running NX-OS
    return 'Cisco::Nexus'
      if ( $desc =~ /^Cisco\s+NX-OS/ );

    # Catalyst WS-C series override 2926,4k,5k,6k in Hybrid
    return 'Cisco::Catalyst' if ( $desc =~ /WS-C\d{4}/ );

    #  Aironet - IOS
    return 'Cisco::AironetIOS'
      if ( $desc
        =~ /\b(C1100|C1130|C1140|AP1200|C350|C1200|C1240|C1250|C2700|C3700)\b/
        && $desc =~ /\bIOS\b/ );

    # Aironet - non IOS
    return 'Cisco::Aironet'
      if ( $desc =~ /Cisco/
        && $desc =~ /\D(BR500|CAP340|AP340|CAP350|350|1200)\D/ );

    return 'Cisco::Aironet'
      if ( $desc =~ /Aironet/ && $desc =~ /\D(AP4800)\D/ );

    # Airespace (WLC) Module
    return 'Cisco::Airespace'
      if ( $desc =~ /^Cisco Controller$/ );

    # Cisco ASA, newer versions which report layer 3 functionality
    # version >= 8.2 are known to do this
    return 'Cisco::ASA'
      if ( $desc =~ /Cisco Adaptive Security Appliance/i );

    # Cisco PIX
    return 'Cisco::Generic'
      if ( $desc =~ /Cisco PIX Security Appliance/i );

    # Cisco FWSM
    return 'Cisco::FWSM'
      if ( $desc =~ /Cisco Firewall Services Module/i );

    #------------------------------------------------------------------#
    #                        HP Devices                                #
    #------------------------------------------------------------------#

    # HP, older ProCurve models (1600, 2400, 2424m, 4000, 8000)
    return 'HP::HP4000'
      if $desc =~ /\b(J4093A|J4110A|J4120A|J4121A|J4122A|J4122B)\b/;

    # HP, Foundry OEM
    return 'HP::HP9300'
      if $desc =~ /\b(J4874A|J4138A|J4139A|J4840A|J4841A)\b/;

    # HP Virtual Connect blade switches
    return 'HP::HPVC'
      if $desc =~ /HP\sVC\s/;

    #------------------------------------------------------------------#
    #                      Nortel Devices                              #
    #------------------------------------------------------------------#

    # Nortel 2270
    return 'Nortel::N2270'
      if ( $desc =~ /Nortel\s+(Networks\s+)??WLAN\s+-\s+Security\s+Switch/ );

    # Nortel (Trapeze) WSS 2300 Series
    return 'Nortel::WSS2300'
      if ( $desc =~ /^(Nortel\s)??Wireless\sSecurity\sSwitch\s23[568][012]\b/ );

    # Nortel ERS (Passport) 1600 Series < version 2.1
    return 'Nortel::ERS1600'
      if $desc =~ /(Passport|Ethernet\s+Routing\s+Switch)-16/i;

    # Nortel Contivity
    return 'NortelContivity' if $desc =~ /(\bCES\b|\bNVR\sV\d)/;

    #  Nortel Business Ethernet Switch
    return 'Nortel::Baystack'
      if ( $desc =~ /^Business Ethernet Switch\s[12]\d\d/i );

    #  ERS - BayStack Numbered
    return 'Nortel::Baystack'
      if $desc =~ /^(BayStack|Ethernet\s+Routing\s+Switch)\s[2345](\d){2,3}/i;

    #  BPS
    return 'Nortel::Baystack' if $desc =~ /Business\sPolicy\sSwitch/i;

    #  Nortel AP 222X
    return 'Nortel::AP222x'
      if ( $desc =~ /Access\s+Point\s+222/ );

    #------------------------------------------------------------------#

    # Allied Telesis Layer2 managed switches.
    return 'Allied'
      if ( $desc =~ /Allied.*AT-80\d{2}\S*/i );

    return 'Allied' if ( $desc =~ /allied/i );

    # Aruba wireless switches
    return 'Aruba'
      if ( $desc =~ /(ArubaOS|AirOS)/ );

    # Alcatel-Lucent branded Aruba
    return 'Aruba'
      if ( $desc =~ /^AOS-W/ );

    return 'Asante' if ( $desc =~ /asante/i );

    #  Bay Hub
    return 'Bayhub'
      if ( $desc =~ /\bNMM.*Agent/ );
    return 'Bayhub'
      if ( $desc =~ /\bBay\s*Stack.*Hub/i );

    #  Centillion ATM
    return 'Centillion' if ( $desc =~ /MCP/ );

    # IBM BladeCenter 4-Port GB Ethernet Switch Module
    return 'Dell'
      if ( $desc =~ /^IBM Gigabit Ethernet Switch Module$/ );

    # Linksys 2024/2048
    return 'Dell'
      if ( $desc
        =~ /^(24|48)-Port 10\/100\/1000 Gigabit Switch (with |w\/)WebView$/ );

    # Foundry
    return 'Foundry' if $desc =~ /foundry/i;

    # Kentrox DataSMART DSU/CSU
    return 'Kentrox'
      if ( $desc =~ /^DataSMART/i );

    #  Orinoco
    return 'Orinoco'
      if ( $desc =~ /(AP-\d{3}|WavePOINT)/ );

    #  Synoptics Hub
    return 'S3000'
      if ( $desc =~ /\bNMM\s+(281|3000|3030)/i );

    # SonicWALL
    return 'SonicWALL' if $desc =~ /SonicWALL/i;

    # Avaya Secure Router
    return 'Tasman'
      if ( $desc =~ /^(avaya|nortel)\s+(SR|secure\srouter)\s+\d{4}/i );
}

1;

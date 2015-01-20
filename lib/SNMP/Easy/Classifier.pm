package SNMP::Easy::Classifier;
#ABSTRACT: Guess SNMP Agent from description

use Moose;
use namespace::autoclean;

our $VERSION = '0.0.0';

has device => (
    is => 'ro',
    isa => 'SNMP::Easy::Device',    
);


sub classify {
    my $self = shift;
    
    my $objtype = "SNMP::Easy::Device";
    my $device = $self->device;
    
    my $services = $device->sysServices;
    my $desc = $device->sysDescr;
    $desc =~ s/[\r\n\l]+/ /g;
    
    my $id = $device->sysObjectID;
    my $vendor = $device->vendor;
       
    $ENV{SNMP_EASY_DEBUG} and
	print "SNMP::Easy::classifier services:$services id:$id sysDescr:\"$desc\" vendor: $vendor\n";
    
    # Some devices don't implement sysServices, but do return a description. 
    # In that case, log a warning and continue.
    if ( ! defined($services) ) {
        if (!defined($desc)) {
            carp("Device doesn't implement sysServices but did return sysDescr. Might give unexpected results.\n") 
        } else {
            # No sysServices, no sysDescr 
            return;
        }
    }

    print "vendor $vendor\n";
    return 'SNMP::Easy::Device::NetSNMP' if $vendor eq 'NetSNMP';
    return $objtype;

    # Layer 3 Supported
    #   (usually has layer2 as well, so we check for 3 first)
    if ( $self->has_layer(3) ) {
        $objtype = 'SNMP::Info::Layer3';

        # Device Type Overrides

        return $objtype unless ( defined $desc and length($desc) );

        $objtype = 'C3550' if $desc =~ /(C3550|C3560)/;
        $objtype = 'C4000' if $desc =~ /Catalyst 4[05]00/;
        $objtype = 'Foundry' if $desc =~ /foundry/i;

        # Aironet - older non-IOS
        $objtype = 'Aironet'
            if ($desc =~ /Cisco/
            and $desc =~ /\D(CAP340|AP340|CAP350|350|1200)\D/ );
        $objtype = 'Aironet'
            if ( $desc =~ /Aironet/ and $desc =~ /\D(AP4800)\D/ );

        # Cat6k with older SUPs (hybrid CatOS/IOS?)
        $objtype = 'C6500' if $desc =~ /(c6sup2|c6sup1)/;

        # Cat6k with Sup720, Sup720 or Sup2T (and Sup2 running native IOS?)
        $objtype = 'C6500'
            if $desc =~ /(s72033_rp|s3223_rp|s32p3_rp|s222_rp|s2t54)/;

        # Next one untested. Reported working by DA
        $objtype = 'C6500'
            if ( $desc =~ /cisco/i and $desc =~ /3750/ );

        # IOS 15.x on Catalyst 3850
        $objtype = 'C6500'
            if ( $desc =~ /cisco/i and $desc =~ /CAT3K/ );

        #   Cisco 2970
        $objtype = 'C6500'
            if ( $desc =~ /(C2970|C2960)/ );

        #   Cisco 3400 w/ Layer3 capable image
        $objtype = 'C3550'
            if ( $desc =~ /(ME340x)/ );

        # Various Cisco blade switches, CBS30x0 and CBS31x0 models
        $objtype = 'C6500'
            if ( $desc =~ /cisco/i and $desc =~ /CBS3[0-9A-Za-z]{3}/ );

        # Cisco Nexus running NX-OS
        $objtype = 'Nexus'
            if ( $desc =~ /^Cisco\s+NX-OS/ );

        # HP, older ProCurve models (1600, 2400, 2424m, 4000, 8000)
        $objtype = 'SNMP::Info::Layer2::HP4000'
            if $desc =~ /\b(J4093A|J4110A|J4120A|J4121A|J4122A|J4122B)\b/;

        # HP, Foundry OEM
        $objtype = 'HP9300'
            if $desc =~ /\b(J4874A|J4138A|J4139A|J4840A|J4841A)\b/;

        # Nortel ERS (Passport) 1600 Series < version 2.1
        $objtype = 'N1600'
            if $desc =~ /(Passport|Ethernet\s+Routing\s+Switch)-16/i;

        #  ERS - BayStack Numbered
        $objtype = 'SNMP::Info::Layer2::Baystack'
            if ( $desc
            =~ /^(BayStack|Ethernet\s+Routing\s+Switch)\s[2345](\d){2,3}/i );

        # Nortel Contivity
        $objtype = 'Contivity' if $desc =~ /(\bCES\b|\bNVR\sV\d)/;

        # SonicWALL
        $objtype = 'SonicWALL' if $desc =~ /SonicWALL/i;

        # Allied Telesis Layer2 managed switches. They report they have L3 support
        $objtype = 'SNMP::Info::Layer2::Allied'
            if ( $desc =~ /Allied.*AT-80\d{2}\S*/i );

        # Cisco ASA, newer versions which report layer 3 functionality
        # version >= 8.2 are known to do this
        $objtype = 'CiscoASA'
            if ( $desc =~ /Cisco Adaptive Security Appliance/i );

        # Cisco FWSM
        $objtype = 'CiscoFWSM'
            if ( $desc =~ /Cisco Firewall Services Module/i );
        
        # Avaya Secure Router
        $objtype = 'Tasman'
            if ( $desc =~ /^(avaya|nortel)\s+(SR|secure\srouter)\s+\d{4}/i );

        # HP Virtual Connect blade switches
        $objtype = 'SNMP::Info::Layer2::HPVC'
            if ( $desc =~ /HP\sVC\s/ );

        # Aironet - IOS
        # Starting with IOS 15, Aironet reports sysServices 6, even though
        # it still is the same layer2 access point.
        $objtype = 'SNMP::Info::Layer2::Aironet'
            if ($desc =~ /\b(C1100|C1130|C1140|AP1200|C350|C1200|C1240|C1250|C2700|C3700)\b/
            and $desc =~ /\bIOS\b/ );

        # Airespace (WLC) Module
        $objtype = 'SNMP::Info::Layer2::Airespace'
            if ( $desc =~ /^Cisco Controller$/ );

        #Nortel 2270
        $objtype = 'SNMP::Info::Layer2::N2270'
            if (
            $desc =~ /Nortel\s+(Networks\s+)??WLAN\s+-\s+Security\s+Switch/ );

        # Nortel (Trapeze) WSS 2300 Series
        $objtype = 'SNMP::Info::Layer2::NWSS2300'    
            if (
            $desc =~ /^(Nortel\s)??Wireless\sSecurity\sSwitch\s23[568][012]\b/);

        # Layer 2 Supported
    }
    elsif ( $self->has_layer(2) ) {
        $objtype = 'SNMP::Info::Layer2';

        return $objtype unless ( defined $desc and $desc !~ /^\s*$/ );

        # Device Type Overrides

        #  Bay Hub (Needed here for layers override)
        $objtype = 'SNMP::Info::Layer1::Bayhub'
            if ( $desc =~ /\bNMM.*Agent/ );
        $objtype = 'SNMP::Info::Layer1::Bayhub'
            if ( $desc =~ /\bBay\s*Stack.*Hub/i );

        #  Synoptics Hub (Needed here for layers override)
        #  This will override Bay Hub only for specific devices supported
        #  by this class
        $objtype = 'SNMP::Info::Layer1::S3000'
            if ( $desc =~ /\bNMM\s+(281|3000|3030)/i );

        #   Catalyst 1900 series override
        $objtype = 'SNMP::Info::Layer2::C1900'
            if ( $desc =~ /catalyst/i and $desc =~ /\D19\d{2}/ );

        #   Catalyst 2900 and 3500XL (IOS) series override
        $objtype = 'SNMP::Info::Layer2::C2900'
            if ( $desc =~ /(C2900XL|C2950|C3500XL|C2940|CGESM|CIGESM)/i );

        #   Catalyst WS-C series override 2926,4k,5k,6k in Hybrid
        $objtype = 'SNMP::Info::Layer2::Catalyst' if ( $desc =~ /WS-C\d{4}/ );

        #   Catalyst 3550 / 3548 Layer2 only switches
        #   Cisco 3400 w/ MetroBase Image
        $objtype = 'C3550'
            if ( $desc =~ /(C3550|ME340x)/ );

        # Cisco blade switches, CBS30x0 and CBS31x0 models with L2 only
        $objtype = 'C6500'
            if ( $desc =~ /cisco/i and $desc =~ /CBS3[0-9A-Za-z]{3}/ );

        #   Cisco 2970
        $objtype = 'C6500'
            if ( $desc =~ /(C2970|C2960)/ );

        #   Cisco Small Business (300 500) series override
        #   This is for enterprises(1).cisco(9).otherEnterprises(6).ciscosb(1)
        $objtype = 'SNMP::Info::Layer2::CiscoSB'
            if ( $id =~ /^\.1\.3\.6\.1\.4\.1\.9\.6\.1/ );
        
        # HP, older ProCurve models (1600, 2400, 2424m, 4000, 8000)
        $objtype = 'SNMP::Info::Layer2::HP4000'
            if $desc =~ /\b(J4093A|J4110A|J4120A|J4121A|J4122A|J4122B)\b/;

        # HP, Foundry OEM
        $objtype = 'HP9300'
            if $desc =~ /\b(J4874A|J4138A|J4139A|J4840A|J4841A)\b/;

        # IBM BladeCenter 4-Port GB Ethernet Switch Module
        $objtype = 'Dell'
            if ( $desc =~ /^IBM Gigabit Ethernet Switch Module$/ );

        # Linksys 2024/2048
        $objtype = 'Dell'
            if (
            $desc =~ /^(24|48)-Port 10\/100\/1000 Gigabit Switch (with |w\/)WebView$/ );

        #  Centillion ATM
        $objtype = 'SNMP::Info::Layer2::Centillion' if ( $desc =~ /MCP/ );

        #  BPS
        $objtype = 'SNMP::Info::Layer2::Baystack'
            if ( $desc =~ /Business\sPolicy\sSwitch/i );

        #  BayStack Numbered
        $objtype = 'SNMP::Info::Layer2::Baystack'
            if ( $desc
            =~ /^(BayStack|Ethernet\s+(Routing\s+)??Switch)\s[2345](\d){2,3}/i
            );

        # Kentrox DataSMART DSU/CSU
        $objtype = 'SNMP::Info::Layer2::Kentrox'
            if ( $desc =~ /^DataSMART/i );

        #  Nortel Business Ethernet Switch
        $objtype = 'SNMP::Info::Layer2::Baystack'
            if ( $desc =~ /^Business Ethernet Switch\s[12]\d\d/i );

        #  Nortel AP 222X
        $objtype = 'SNMP::Info::Layer2::NAP222x'
            if ( $desc =~ /Access\s+Point\s+222/ );

        #  Orinoco
        $objtype = 'SNMP::Info::Layer2::Orinoco'
            if ( $desc =~ /(AP-\d{3}|WavePOINT)/ );

        #  Aironet - IOS
        $objtype = 'SNMP::Info::Layer2::Aironet'
            if ($desc =~ /\b(C1100|C1130|C1140|AP1200|C350|C1200|C1240|C1250)\b/
            and $desc =~ /\bIOS\b/ );

        # Aironet - non IOS
        $objtype = 'Aironet'
            if ( $desc =~ /Cisco/ and $desc =~ /\D(BR500)\D/ );

        # Airespace (WLC) Module
        $objtype = 'SNMP::Info::Layer2::Airespace'
            if ( $desc =~ /^Cisco Controller$/ );

        #Nortel 2270
        $objtype = 'SNMP::Info::Layer2::N2270'
            if (
            $desc =~ /Nortel\s+(Networks\s+)??WLAN\s+-\s+Security\s+Switch/ );

        # HP Virtual Connect blade switches
        $objtype = 'SNMP::Info::Layer2::HPVC'
            if ( $desc =~ /HP\sVC\s/ );

        $objtype = 'SNMP::Info::Layer2::ZyXEL_DSLAM'
            if ( $desc =~ /8-port .DSL Module\(Annex .\)/i );

    }
    elsif ( $self->has_layer(1) ) {
        $objtype = 'SNMP::Info::Layer1';

        #  Allied crap-o-hub
        $objtype = 'SNMP::Info::Layer1::Allied' if ( $desc =~ /allied/i );
        $objtype = 'SNMP::Info::Layer1::Asante' if ( $desc =~ /asante/i );

        #  Bay Hub
        $objtype = 'SNMP::Info::Layer1::Bayhub'
            if ( $desc =~ /\bNMM.*Agent/ );
        $objtype = 'SNMP::Info::Layer1::Bayhub'
            if ( $desc =~ /\bBay\s*Stack.*Hub/i );

        #  Synoptics Hub
        #  This will override Bay Hub only for specific devices supported
        #  by this class
        $objtype = 'SNMP::Info::Layer1::S3000'
            if ( $desc =~ /\bNMM\s+(281|3000|3030)/i );

     
    }
    # These devices don't claim to have Layer1-3 but we like em anyways.
    else {
        $objtype = 'SNMP::Info::Layer2::ZyXEL_DSLAM'
            if ( $desc =~ /8-port .DSL Module\(Annex .\)/i );

        # Aruba wireless switches
        $objtype = 'Aruba'
            if ( $desc =~ /(ArubaOS|AirOS)/ );

        # Alcatel-Lucent branded Aruba
        $objtype = 'Aruba'
            if ( $desc =~ /^AOS-W/ );

        # Cisco PIX
        $objtype = 'Cisco'
            if ( $desc =~ /Cisco PIX Security Appliance/i );

        # Cisco ASA, older version which doesn't report layer 3 functionality
        $objtype = 'CiscoASA'
            if ( $desc =~ /Cisco Adaptive Security Appliance/i );

        # HP Virtual Connect blade switches
        $objtype = 'SNMP::Info::Layer2::HPVC'
            if ( $desc =~ /HP\sVC\s/ );

        # Nortel (Trapeze) WSS 2300 Series
        $objtype = 'SNMP::Info::Layer2::NWSS2300'    
            if (
            $desc =~ /^(Nortel\s)??Wireless\sSecurity\sSwitch\s23[568][012]\b/);
       
    }

    return $objtype;
    
}


1;

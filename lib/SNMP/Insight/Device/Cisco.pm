package SNMP::Insight::Device::Cisco;

# ABSTRACT: Support for generic Cisco devices

# Portions based on SNMP::Info.
# Copyright (c) 2003-2012 Max Baker and SNMP::Info Developers
# All rights reserved.

use Moose::Role;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB::Cisco_CDP', 'SNMP::Insight::MIB::Entity';

sub _build_vendor {
    return 'Cisco';
}

sub _build_os {
    my $self = shift;
    my $descr = $self->sysDescr() || '';

    # order here matters - there are Catalysts that run IOS and have catalyst
    # in their description field, as well as Catalysts that run IOS-XE.

    return 'ios-xe'   if ( $descr =~ /IOS-XE/ );
    return 'ios-xr'   if ( $descr =~ /IOS XR/ );
    return 'ios'      if ( $descr =~ /IOS/ );
    return 'catalyst' if ( $descr =~ /catalyst/i );
    return 'css'      if ( $descr =~ /Content Switch SW/ );
    return 'css-sca'  if ( $descr =~ /Cisco Systems Inc CSS-SCA-/ );
    return 'pix'      if ( $descr =~ /Cisco PIX Security Appliance/ );
    return 'asa'      if ( $descr =~ /Cisco Adaptive Security Appliance/ );
    return 'san-os'   if ( $descr =~ /Cisco SAN-OS/ );

    return;
}

sub _build_os_version {
    my $self  = shift;
    my $os    = $self->os();
    my $descr = $self->sysDescr();

    if ( defined $os && defined $descr ) {

        # Older Catalysts
        if ( $os eq 'catalyst' && $descr =~ m/V(\d{1}\.\d{2}\.\d{2})/ ) {
            return $1;
        }

        if (   $os eq 'css'
            && $descr
            =~ m/Content Switch SW Version ([0-9\.\(\)]+) with SNMPv1\/v2c Agent/
          )
        {
            return $1;
        }

        if (   $os eq 'css-sca'
            && $descr
            =~ m/Cisco Systems Inc CSS-SCA-2FE-K9, ([0-9\.\(\)]+) Release / )
        {
            return $1;
        }

        if (   $os eq 'pix'
            && $descr
            =~ m/Cisco PIX Security Appliance Version ([0-9\.\(\)]+)/ )
        {
            return $1;
        }

        if (   $os eq 'asa'
            && $descr
            =~ m/Cisco Adaptive Security Appliance Version ([0-9\.\(\)]+)/ )
        {
            return $1;
        }

        if ( $os =~ /^fwsm/ && $descr =~ m/Version (\d+\.\d+(\(\d+\)){0,1})/ ) {
            return $1;
        }

        if ( $os eq 'ios-xr' && $descr =~ m/Version (\d+[\.\d]+)/ ) {
            return $1;
        }

    }

    if ( $os =~ /^ace/ && $self->can('entPhysicalSoftwareRev') ) {
        my $ver = $self->entPhysicalSoftwareRev->{1};
        $ver and return $ver;
    }

    # Newer Catalysts and IOS devices
    if ( defined $descr
        and $descr =~ m/Version (\d+\.\d+\([^)]+\)[^,\s]*)(,|\s)+/ )
    {
        return $1;
    }

    # Generic fallback: try to determine running image from CISCO-IMAGE-MIB
    # my $image_info = $l2->ciscoImageString() || {};
    # foreach my $row ( keys %$image_info ) {
    #    my $info_string = $image_info->{$row};
    #    if ( $info_string =~ /CW_VERSION\$([^\$]+)\$/ ) {
    #        return $1;
    #    }
    #}

    return;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


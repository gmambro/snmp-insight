package SNMP::Easy::Device::Catalyst;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

our $VERSION = '0.0.0';

with
  'SNMP::Easy::MIB::RFC1213',
  'SNMP::Easy::MIB::BRIDGE',
  'SNMP::Easy::MIB::CISCO_VTP',
  'SNMP::Easy::MIB::CISCO_CDP',
  'SNMP::Easy::MIB::IP',
  'SNMP::Easy::MIB::CISCO_2900',
  'SNMP::Easy::MIB::CISCO_PORT_SECURITY',
  'SNMP::Easy::MIB::CISCO_VLAN_MEMB',
  'SNMP::Easy::MIB::IF_TABLE_REL',
  'SNMP::Easy::MIB::CISCO_VTP',
  'SNMP::Easy::MIB::ETHERLIKE';

sub os {
    my $self = shift;
    my $descr = $self->sysDescr || '';

    # order here matters - there are Catalysts that run IOS and have catalyst
    # in their description field.
    return 'ios'      if ( $descr =~ /IOS/ );
    return 'catalyst' if ( $descr =~ /catalyst/i );
    return;
}

sub model {
    my $self = shift;
    my $id   = $self->sysObjectID;

    unless ( defined $id ) {
        return;
    }

    my $model = $self->translate($id);

    return $id unless defined $model;

    $model =~ s/^cisco//i;
    $model =~ s/^catalyst//;
    $model =~ s/^cat//;
    return $model;
}

sub os_ver {
    my $self  = shift;
    my $os    = $self->os();
    my $descr = $self->sysDescr();

    # Older Catalysts
    if (    defined $os
        and $os eq 'catalyst'
        and defined $descr
        and $descr =~ m/V(\d{1}\.\d{2}\.\d{2})/ )
    {
        return $1;
    }

    # Newer Catalysts and IOS devices
    if ( defined $descr
        and $descr =~ m/Version (\d+\.\d+\([^)]+\)[^,\s]*)(,|\s)+/ )
    {
        return $1;
    }
    return;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


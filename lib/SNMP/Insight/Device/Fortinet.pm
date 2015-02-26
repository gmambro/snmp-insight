package SNMP::Insight::Device::Fortinet;

# ABSTRACT: Support for generic Fortinet devices

# Portions based on SNMP::Info.
# Copyright (c) 2003-2012 Max Baker and SNMP::Info Developers
# All rights reserved.

use Moose::Role;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB::Fortinet',
     'SNMP::Insight::MIB::IFMIB',
     'SNMP::Insight::MIB::IP';

sub _build_vendor {
    return 'Fortinet';
}

sub _build_os {
    return 'FortiOS';
}

sub _build_os_version {
    my $self  = shift;

    return $self->fnSysVersion();
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


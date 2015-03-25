package SNMP::Insight::Device::Juniper;

# ABSTRACT: Support for generic Juniper devices

# Portions based on SNMP::Info.
# Copyright (c) 2003-2012 Max Baker and SNMP::Info Developers
# All rights reserved.

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::Juniper',
  'SNMP::Insight::MIB::HostResources',
  'SNMP::Insight::MIB::EtherLike',
  'SNMP::Insight::MIB::IP';

sub _build_vendor {
    return 'Juniper';
}

sub _build_os {
    return 'JunOS';
}

sub _build_os_version {
    my $self = shift;

    my $softwares = $self->hrSWInstalledName();

    foreach my $sw ( values $softwares ) {
        $sw =~ m/JUNOS\s+Software\s+Release\s+\[(.+)\]/i
          and return "$1";
    }

    return '';
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


package SNMP::Insight::Device::Microsoft;

#ABSTRACT: Support for Microsoft Windows agent

use Moose::Role;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB::HostResources';

sub _build_vendor {
    return 'Microsoft';
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


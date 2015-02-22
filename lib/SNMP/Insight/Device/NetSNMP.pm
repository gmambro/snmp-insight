package SNMP::Insight::Device::NetSNMP;

#ABSTRACT: Support for Net-SNMP agent

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::UCD',
  'SNMP::Insight::MIB::HostResources';

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


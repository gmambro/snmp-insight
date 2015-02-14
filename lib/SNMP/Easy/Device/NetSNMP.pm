package SNMP::Easy::Device::NetSNMP;

#ABSTRACT: Support for Net-SNMP agent

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Easy::MIB::UCD',
    'SNMP::Easy::MIB::IFMIB',
    'SNMP::Easy::MIB::HostResources';

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


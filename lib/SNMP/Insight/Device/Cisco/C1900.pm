package SNMP::Insight::Device::Cisco::C1900;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::Device::Cisco',

  'SNMP::Insight::MIB::Bridge',
  'SNMP::Insight::MIB::IEEE8023_LAG',
  'SNMP::Insight::MIB::Cisco_PAGP',
  'SNMP::Insight::MIB::Cisco_StpExtensions',
  'SNMP::Insight::Abstraction::Bridge',
  'SNMP::Insight::Device::Cisco::AggRole';

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


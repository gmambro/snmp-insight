package SNMP::Insight::Device::Cisco::C1900;

# ABSTRACT: Support for Cisco 1900 with CatOS

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

warn "STAND-ALONE-ETHERNET-SWITCH-MIB not implemented yet";

sub _build_os { return 'CatOS' }

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


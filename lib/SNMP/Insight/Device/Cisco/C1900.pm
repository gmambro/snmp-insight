package SNMP::Insight::Device::Cisco::C1900;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::IFMIB',
  'SNMP::Insight::MIB::Bridge',
  'SNMP::Insight::MIB::CISCO_CDP',

  # 'SNMP::Insight::MIB::Cisco_Agg',
  # 'SNMP::Insight::MIB::Cisco_Stats',
  # 'SNMP::Insight::MIB::Cisco_StpExtensions',
  ;

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


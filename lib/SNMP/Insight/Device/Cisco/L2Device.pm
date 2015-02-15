package SNMP::Insight::Device::Cisco::L2Device;

# ABSTRACT: Support for Generic Cisco L2 device

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::Cisco_VTP',
  'SNMP::Insight::MIB::Cisco_CDP';
  # 'SNMP::Insight::MIB::Cisco_Agg',
  # 'SNMP::Insight::MIB::Cisco_Stats',
  # 'SNMP::Insight::MIB::Cisco_RTT',
  # 'SNMP::Insight::MIB::Cisco_Config',
  # 'SNMP::Insight::MIB::Cisco_PortSecurity',
  # 'SNMP::Insight::MIB::Cisco_StpExtensions',

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

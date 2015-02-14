package SNMP::Easy::Device::Cisco::L2Device;

# ABSTRACT: Support for Generic Cisco L2 device

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Easy::MIB::Cisco_VTP',
  'SNMP::Easy::MIB::Cisco_CDP',

  # 'SNMP::Easy::MIB::Cisco_Agg',
  # 'SNMP::Easy::MIB::Cisco_Stats',
  # 'SNMP::Easy::MIB::Cisco_RTT',
  # 'SNMP::Easy::MIB::Cisco_Config',
  # 'SNMP::Easy::MIB::Cisco_PortSecurity',
  # 'SNMP::Easy::MIB::Cisco_StpExtensions',
  ;
1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

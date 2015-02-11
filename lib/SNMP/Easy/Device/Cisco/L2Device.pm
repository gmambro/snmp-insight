package SNMP::Easy::Device::Cisco::L2Switch;

# ABSTRACT: Support for Generic Cisco L2 switch

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
    'SNMP::Easy::MIB::Cisco_VTP',
    'SNMP::Easy::MIB::Cisco_CDP',
    # 'SNMP::Easy::MIB::Cisco_Stats',
    # 'SNMP::Easy::MIB::Cisco_RTT',    
    # 'SNMP::Easy::MIB::Cisco_Config',
    # 'SNMP::Easy::MIB::Cisco_PortSecurity',
    # 'SNMP::Easy::MIB::Cisco_StpExtensions',
    # 'SNMP::Easy::MIB::Cisco_Agg'
    ;

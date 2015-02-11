package SNMP::Easy::Device::Cisco::L3Switch;

# ABSTRACT: Support for Generic Cisco L3 switch

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
    'SNMP::Easy::Device::Cisco::L2Device',
    # 'SNMP::Easy::MIB::Cisco_QOS',    
    ;

package SNMP::Insight::Device::Cisco::Airespace;

# ABSTRACT: Support for Cisco Airespace Wireless controllers

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::Device::Cisco',
  'SNMP::Insight::MIB::Bridge',

  # 'SNMP::Insight::MIB::Cisco_LWAPP_DOT11_CLIENT',
  # 'SNMP::Insight::MIB::Cisco_LWAPP_DOT11',
  # 'SNMP::Insight::MIB::Cisco_LWAPP_AP',
  # 'SNMP::Insight::MIB::Airespace_Wireless',
  # 'SNMP::Insight::MIB::Airespace_Switching',

  ;

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


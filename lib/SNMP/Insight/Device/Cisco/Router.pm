package SNMP::Insight::Device::Cisco::Router;

# ABSTRACT: Support for Cisco Router devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::Device::Cisco', 'SNMP::Insight::MIB::IP',

  # 'SNMP::Insight::MIB::Cisco_QOS'
  #CiscoConfig
  ;

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


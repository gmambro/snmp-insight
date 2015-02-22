package SNMP::Insight::Device::Cisco::Aironet;

# ABSTRACT: Support for Cisco Aironet devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::Device::Cisco',
  'SNMP::Insight::MIB::Bridge',

  # AWCVX-MIB
  # IEEE802dot11-MIB
  ;

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


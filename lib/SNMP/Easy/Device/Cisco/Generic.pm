package SNMP::Easy::Device::Cisco::Generic;

# ABSTRACT: Support for generic Cisco devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Easy::MIB::IFMIB',
  'SNMP::Easy::MIB::Bridge',
  'SNMP::Easy::MIB::CISCO_CDP';

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


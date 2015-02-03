package SNMP::Easy::Device::Cisco::C1900;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Easy::MIB::RFC1213',
  'SNMP::Easy::MIB::BRIDGE',
  'SNMP::Easy::MIB::CISCO_CDP';

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


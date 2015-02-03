package SNMP::Easy::Device::3Com;

#ABSTRACT: Support for generic 3Com devices
use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Easy::MIB::RFC1213',
  'SNMP::Easy::MIB::BRIDGE';

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

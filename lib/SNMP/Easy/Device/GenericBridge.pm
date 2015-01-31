package SNMP::Easy::Device::GenericBridge;

#ABSTRACT: Support for generic bridge devices

use Moose::Role;
use namespace::autoclean;

our $VERSION = '0.0.0';

with
  'SNMP::Easy::MIB::RFC1213',
  'SNMP::Easy::MIB::BRIDGE',
  ;

__PACKAGE__->meta->make_immutable;
1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


package SNMP::Easy::Device::Cisco::AironetIOS;

# ABSTRACT: Support for Cisco AironetIOS devices

use Moose::Role;
use namespace::autoclean;

our $VERSION = '0.0.0';

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


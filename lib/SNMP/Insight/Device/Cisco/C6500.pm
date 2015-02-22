package SNMP::Insight::Device::Cisco::C6500;

# ABSTRACT: Support for Cisco Catalyst 6500 devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::Device::Cisco',
  'SNMP::Insight::MIB::Bridge';

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


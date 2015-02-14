package SNMP::Insight::Device::Cisco::Airespace;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::IFMIB',
  'SNMP::Insight::MIB::Bridge',
  'SNMP::Insight::MIB::CISCO_CDP';

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


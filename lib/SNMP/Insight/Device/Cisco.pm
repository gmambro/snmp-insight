package SNMP::Insight::Device::Cisco;

# ABSTRACT: Support for generic Cisco devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::IFMIB',
  'SNMP::Insight::MIB::Cisco_CDP';

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


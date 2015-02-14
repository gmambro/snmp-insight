package SNMP::Insight::Device::3Com;

#ABSTRACT: Support for generic 3Com devices
use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::MIB::IFMIB',
  'SNMP::Insight::MIB::Bridge';

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

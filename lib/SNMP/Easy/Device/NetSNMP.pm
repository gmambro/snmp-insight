package SNMP::Easy::Device::NetSNMP;
#ABSTRACT: Support for Net-SNMP agent

use Moose::Role;
use namespace::autoclean;

our $VERSION = '0.0.0';

with
    'SNMP::Easy::MIB::UCD',
    'SNMP::Easy::MIB::IFMIB';

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


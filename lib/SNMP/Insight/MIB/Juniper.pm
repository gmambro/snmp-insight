package SNMP::Insight::MIB::Juniper;

#ABSTRACT: Support for data in JUNIPER-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.2636";
mib_name "JUNIPER-MIB";

has_scalar jnxBoxDescr => ( oid => '3.1.2' );

has_scalar jnxBoxSerialNo => ( oid => '3.1.3' );

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

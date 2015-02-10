package SNMP::Easy::MIB::Bridge;

#ABSTRACT: Support for data in Bridge-MIB

use Moose::Role;

#VERSION:

use SNMP::Easy::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Easy::MIB';

mib_oid "1.3.6.1.2.1.17";
mib_name "Bridge-MIB";

# .1 dot1dBase

has_scalar "dot1dBaseBridgeAddress" => (
    oid    => "1.1",
    munger => 'munge_macaddress',
);

has_scalar "dot1dBaseNumPorts" => ( oid => "1.2" );

has_table "dot1dBasePortTable" => (
    oid     => "1.4",
    index   => "dot1dBasePort",
    columns => {
        "dot1dBasePort"        => 1,
        "dot1dBasePortIfIndex" => 2
    }
);

# .4 to1dTp

has_table "dot1dTpFdbEntry" => (
    oid     => "4.3",
    index   => "dot1dTpFdbAddress",
    columns => {
        "dot1dTpFdbAddress" => [ 1, 'munge_macaddress' ],
        "dot1dTpFdbPort"    => 2,
        "dot1dTpFdbStatus"  => 3,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

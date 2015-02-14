package SNMP::Easy::MIB::CISCO_VTP;

#ABSTRACT: Support for data in CISCO-VTP-MIB

use Moose::Role;

#VERSION:

use SNMP::Easy::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Easy::MIB';

mib_oid "1.3.6.1.4.1.9.9.";

mib_name "CISCO-VTP-MIB";

has_scalar 'vtpVersion' => ( oid => '1.1.1', );

has_scalar 'vtpMaxVlanStorage' => ( oid => '1.1.2', );

# This table contains information on the VLANs which currently exist.
has_table 'vtpVlanTable' => (
    oid     => '1.3',
    index   => 'vtpVlanIndex',
    columns => {
        vtpVlanIndex   => 1,
        vtpVlanState   => 2,
        vtpVlanType    => 3,
        vtpVlanName    => 4,
        vtpVlanTypeExt => 17,
        vtpVlanIfIndex => 18
    },
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

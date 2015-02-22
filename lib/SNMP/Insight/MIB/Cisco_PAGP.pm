package SNMP::Insight::MIB::Cisco_PAGP;

#ABSTRACT: Support for data in Cisco PAGP MIB

use Moose::Role;

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB';

mib_name 'CISCO-PAGP-MIB';
mib_oid '1.3.6.1.4.1.9.9.98';

has_table 'pagpEtherChannelTable' => (
    oid     => '1.1.1',
    columns => {
        pagpEthcOperationMode => 1,
        pagpGroupIfIndex      => 8,
    },
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

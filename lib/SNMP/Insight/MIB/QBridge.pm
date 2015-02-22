package SNMP::Insight::MIB::QBridge;

#ABSTRACT: Support for data in Q-BRIDGE-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.2.1.17.7";
mib_name "Q-BRIDGE-MIB";

warn "QBridge stub: to be implemented";

# Q-BRIDGE-MIB is a subtree of BRIDGE-MIB

has_table "dot1qVlanCurrentTable" => (
    oid    => "1.4.2",
    # should be a complex index, use this just for syntax check
    index => 'dot1qVlanCurrentEgressPorts',
    columns => {
        dot1qVlanCurrentEgressPorts   => 4,
        dot1qVlanCurrentUntaggedPorts => 5,
        dot1qVlanStatus => 6,
    }
);


has_table "dot1qVlanStaticTable" => (
    oid    => "1.4.3",
    # index for syntax check
    index => 'dot1qVlanStaticName',
    columns => {
        dot1qVlanStaticName => 1,
        dot1qVlanStaticEgressPorts => 2,
        dot1qVlanForbiddenEgressPorts => 3,
        dot1qVlanStaticUntaggedPorts => 4,
        dot1qVlanStaticRowStatus => 5,
    }
);


has_table "dot1qPortVlanTable" => (
    oid    => "1.4.5",
    # for syntax check
    index => 'dot1qPvid',
    columns => {
        dot1qPvid => 1,
	dot1qPortAcceptableFrameTypes => 2,
        dot1qPortIngressFiltering => 3,
    },
);


1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

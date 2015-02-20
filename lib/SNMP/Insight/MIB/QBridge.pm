package SNMP::Insight::MIB::QBridge;

#ABSTRACT: Support for data in Q-BRIDGE-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB', 'SNMP::Insight::MIB::Bridge';

mib_oid "1.3.6.1.2.1.17.7";
mib_name "Q-BRIDGE-MIB";

warn "QBridge stub: to be implemented";

# Q-BRIDGE-MIB is a subtree of BRIDGE-MIB

# split Dot1qTpFdbEntry index into FDB ID and MAC Address.
#sub munge_qtpfdb_index {
#    my $idx    = shift;
#    my @values = split( /\./, $idx );
#    my $fdb_id = shift(@values);
#    return ( $fdb_id, join( ':', map { sprintf "%02x", $_ } @values ) );
#}

=attr dot1qVlanCurrentTable

A table containing current configuration information
for each VLAN currently configured into the device by
(local or network) management, or dynamically created
as a result of GVRP requests received.

=cut

has_table "dot1qVlanCurrentTable" => (
    oid => "1.4.2",

    # should be a complex index, use this just for syntax check
    index   => 'dot1qVlanCurrentEgressPorts',
    columns => {
        dot1qVlanCurrentEgressPorts   => [ 4, 'munge_port_list' ],
        dot1qVlanCurrentUntaggedPorts => [ 5, 'munge_port_list' ],
        dot1qVlanStatus               => 6,
    }
);

=func munge_vlan_static_row_status 

Munger for dot1qVlanStaticRowStatus

=cut

sub munge_vlan_static_row_status {
    my $val = shift;
    $val or return;

    my %row_status = (
        1 => 'active',
        2 => 'notInService',
        3 => 'notReady',
        4 => 'createAndGo',
        5 => 'createAndWait',
        6 => 'destroy'
    );

    return $row_status{$val} || $val;
}

=attr dot1qVlanStaticTable

A table containing static configuration information for each VLAN
configured into the device by (local or network) management. All
entries are permanent and will be restored after the device is reset

=cut

has_table "dot1qVlanStaticTable" => (
    oid     => "1.4.3",
    index   => 'dot1qVlanStaticName',
    columns => {
        dot1qVlanStaticName           => 1,
        dot1qVlanStaticEgressPorts    => [ 2, 'munge_port_list' ],
        dot1qVlanForbiddenEgressPorts => [ 3, 'munge_port_list' ],
        dot1qVlanStaticUntaggedPorts  => [ 4, 'munge_port_list' ],
        dot1qVlanStaticRowStatus      => [ 5, 'munge_vlan_static_row_status' ],
    }
);

=attr dot1qPortVlanTable

A table containing per port control and status information for VLAN
configuration in the device.  

=cut

has_table "dot1qPortVlanTable" => (
    oid => "1.4.5",

    # for syntax check
    index   => 'dot1dBasePort',
    columns => {
        dot1qPvid                     => 1,
        dot1qPortAcceptableFrameTypes => 2,
        dot1qPortIngressFiltering     => 3,
    },
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

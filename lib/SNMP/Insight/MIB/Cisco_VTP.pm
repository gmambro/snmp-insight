package SNMP::Insight::MIB::Cisco_VTP;

#ABSTRACT: Support for data in CISCO-VTP-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.9.9.46.1";

mib_name "CISCO-VTP-MIB";

has_scalar 'vtpVersion' => (
    oid => '1.1',
);

has_scalar 'vtpMaxVlanStorage' => ( oid => '1.2', );

has_scalar 'vtpNotificationsEnabled' =>
  ( oid => '1.3', munger => 'munge_enabled' );

has_scalar 'vtpVlanCreatedNotifEnabled' =>
  ( oid => '1.4', munger => 'munge_enabled' );

has_scalar 'vtpVlanDeletedNotifEnabled' =>
  ( oid => '1.5', munger => 'munge_enabled' );

has_table 'vlanManagementDomains' => (
    oid     => '2.1',
    index   => 'managementDomainIndex',
    columns => {
        managementDomainIndex           => 1,
        managementDomainName            => 2,
        managementDomainLocalMode       => [ 3, 'munge_managementmode' ],
        managementDomainConfigRevNumber => 4,
        managementDomainLastUpdater     => 5,
        managementDomainLastChange      => 6,
        managementDomainRowStatus       => 7,
        managementDomainTftpServer      => 8,
        managementDomainTftpPathname    => 9,
        managementDomainPruningState    => [ 10, 'munge_enabled' ],
        managementDomainVersionInUse    => [ 11, 'munge_mngdomain' ],
    },
);

# This table contains information on the VLANs which currently exist.
has_table 'vtpVlanTable' => (
    oid     => '3.1',
    index   => 'vtpVlanIndex',
    columns => {
        vtpVlanIndex => 1,
        vtpVlanState => [ 2, 'munge_state' ],
        vtpVlanType  => [ 3, 'munge_vlantype' ],
        vtpVlanName  => 4,
        vtpVlanMtu   => 5,

        # vtpVlanDot10Said => 6,
        vtpVlanTranslationalVlan1 => 11,
        vtpVlanTranslationalVlan2 => 12,

        # vtpVlanTypeExt   => 17,
        vtpVlanIfIndex => 18
    },
);

has_table 'vtpStatsTable' => (
    oid     => '5.1',
    columns => {
        vtpInSummaryAdverts      => 1,
        vtpInSubsetAdverts       => 2,
        vtpInAdvertRequests      => 3,
        vtpOutSummaryAdverts     => 4,
        vtpOutSubsetAdverts      => 5,
        vtpOutAdvertRequests     => 6,
        vtpConfigRevNumberErrors => 7,
        vtpConfigDigestErrors    => 8,
    }
);

has_table 'vlanTrunkPorts' => (
    oid     => '6.1',
    index   => 'vlanTrunkPortIfIndex',
    columns => {
        vlanTrunkPortIfIndex           => 1,
        vlanTrunkPortManagementDomain  => 2,
        vlanTrunkPortEncapsulationType => [ 3, 'munge_enctype' ],
        vlanTrunkPortVlansEnabled      => [ 4, 'munge_membership_vlan' ],
        vlanTrunkPortNativeVlan        => 5,
        vlanTrunkPortRowStatus         => 6,
        vlanTrunkPortInJoins           => 7,
        vlanTrunkPortOutJoins          => 8,

        # vlanTrunkPortOldAdverts            => 9,
        # vlanTrunkPortVlansPruningEligible  => 10,
        # vlanTrunkPortVlansXmitJoined       => 11,
        vlanTrunkPortDynamicState          => [ 13, 'munge_dynstate' ],
        vlanTrunkPortDynamicStatus         => [ 14, 'munge_dynstatus' ],
        vlanTrunkPortVtpEnabled            => 15,
        vlanTrunkPortEncapsulationOperType => [ 16, 'munge_enctype' ],

        # vlanTrunkPortVlansEnabled2k        => [17,'munge_membership_vlan'],
        # vlanTrunkPortVlansEnabled3k        => [18,'munge_membership_vlan'],
        # vlanTrunkPortVlansEnabled4k        => [19,'munge_membership_vlan'],
        # vtpVlansPruningEligible2k          => 20,
        # vtpVlansPruningEligible3k          => 21,
        # vtpVlansPruningEligible4k          => 22,
        # vlanTrunkPortVlansXmitJoined2k     => 23,
        # vlanTrunkPortVlansXmitJoined3k     => 24,
        # vlanTrunkPortVlansXmitJoined4k     => 25,
        vlanTrunkPortDot1qTunnel => [ 29, 'munge_dot1qtun' ],
    }
);

=func munge_vlantype

Munge a vtpVlanType

=cut

sub munge_vlantype {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'ieee',
        2 => 'ibm',
        3 => 'hybrid',
    );
    return $ENUM{$val};
}

=func munge_dot1qtun

Munge vlanTrunkPortDot1qTunnel

=cut

sub munge_dot1qtun {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'trunkg',
        2 => 'access',
        3 => 'disabled',
    );
    return $ENUM{$val};
}

=func munge_dynstatus

Munge vlanTrunkPortDynamicStatus

=cut 

sub munge_dynstatus {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'trunking',
        2 => 'notTrunking',
    );
    return $ENUM{$val};
}

=func munge_dynstate

Munge vlanTrunkPortDynamicState

=cut

sub munge_dynstate {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'isl',
        2 => 'dot10',
        3 => 'lane',
        4 => 'dot1Q',
        5 => 'negotiate',
        6 => 'notApplicable',
    );
    return $ENUM{$val};
}

=func munge_enctype

Munge a vlan encapsulation type

=cut

sub munge_enctype {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'on',
        2 => 'off',
        3 => 'desirable',
        4 => 'auto',
        5 => 'onNoNegotiate',
    );
    return $ENUM{$val};
}

=func munge_mngdomain

Munge a VTP Domain version

=cut

sub munge_mngdomain {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'version1',
        2 => 'version2',
        3 => 'none',
        4 => 'version3',
    );
    return $ENUM{$val};
}

=func munge_enabled

Munge an enabled enumeration

=cut

sub munge_enabled {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'enabled',
        2 => 'disabled',
    );
    return $ENUM{$val};
}

=func munge_state

Munge a vlan state

=cut

sub munge_state {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'operational',
        2 => 'suspended',
        3 => 'mtuTooBigForDevice',
        4 => 'mtuTooBigForTrunk',
    );
    return $ENUM{$val};
}

=func munge_managementmode

Munge a vlan management mode

=cut

sub munge_managementmode {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'client',
        2 => 'server',
        3 => 'transparent',
        4 => 'off',
    );
    return $ENUM{$val};
}

=func munge_membership_vlan

Convert a membership bitset to a vlan list

=cut 

sub munge_membership_vlan {
    my $val = shift;
    $val or return;

    my $vlanlist = [ split( //, unpack( "B*", $val ) ) ];
    return $vlanlist;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

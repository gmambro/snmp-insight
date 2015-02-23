package SNMP::Insight::MIB::Cisco_PortSecurity;

#ABSTRACT: Support for data in CISCO-PORTSECURITY-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.9.9.315";
mib_name "CISCO-PORTSECURITY-MIB";

=attr cpsIfConfigTable

A list of port security configuration entries.  The number of entries
is determined by the number of interfaces in the system that can
support the port security feature. Interfaces that are not port
security capable will not be displayed in this Table. This table
includes interfaces on which port security parameters can be set even
if port security feature itself cannot be enabled due to conflict with
other features.

=cut

has_table cpsIfConfigTable => (
    oid     => '1.2.1',
    columns => {
        cpsIfPortSecurityEnable        => 1,
        cpsIfPortSecurityStatus        => 2,
        cpsIfMaxSecureMacAddr          => 3,
        cpsIfCurrentSecureMacAddrCount => 4,
        cpsIfSecureMacAddrAgingTime    => 5,
        cpsIfSecureMacAddrAgingType    => 6,
        cpsIfStaticMacAddrAgingEnable  => 7,
        cpsIfViolationAction           => 8,
        cpsIfViolationCount            => 9,
        cpsIfSecureLastMacAddress      => 10,
        cpsIfClearSecureAddresses      => 11,
        cpsIfUnicastFloodingEnable     => 12,
        cpsIfShutdownTimeout           => 13,
        cpsIfClearSecureMacAddresses   => 14,
        cpsIfStickyEnable              => 15,
        cpsIfInvalidSrcRateLimitEnable => 16,
        cpsIfInvalidSrcRateLimitValue  => 17,
        cpsIfSecureLastMacAddrVlanId   => 18,
    },
);

=attr cpsSecureMacAddressTable

A list of port security entries containing the secure MAC address
information.

=cut

has_table cpsSecureMacAddressTable => (
    oid     => '1.2.2',
    columns => {
        cpsSecureMacAddress          => 1,
        cpsSecureMacAddrType         => 2,
        cpsSecureMacAddrRemainingAge => 3,
        cpsSecureMacAddrRowStatus    => 4,
    }
);

=attr cpsIfVlanSecureMacAddrTable

A list of port security entries containing the secure MAC address
information. This table is simolar to cpsSecureMacAddressTable except
that cpsIfVlanSecureVlanIndex is part of the INDEX clause.

This table is used to configure a secure MAC address on either an
access interface or trunking interface which support port security
feature.

=cut

has_table cpsIfVlanSecureMacAddrTable => (
    oid     => '1.2.3',
    columns => {
        cpsIfVlanSecureMacAddress       => 1,
        cpsIfVlanSecureVlanIndex        => 2,
        cpsIfVlanSecureMacAddrType      => 3,
        cpsIfVlanSecureMacAddrRemainAge => 4,
        cpsIfVlanSecureMacAddrRowStatus => 5,
    }
);

=attr cpsIfVlanTable

Each entry in this table represents port-security information for each
vlan that is allowed on trunk interface.

The number of entries is determined by the number of allowed VLANs on
trunk interface in the system.

An Entry in the table gets created when a vlan becomes allowed and
gets deleted when a vlan becomes disallowed on a trunk port.

User cannot create new entries in this table, but can only read and
modify existing entries.

This table is obsolete and replaced with cpsIfMultiVlanTable.

=cut

has_table cpsIfVlanTable => (
    oid     => '1.2.4',
    columns => {
        cpsIfVlanIndex                 => 1,
        cpsIfVlanMaxSecureMacAddr      => 2,
        cpsIfVlanCurSecureMacAddrCount => 3,
    },
);

=attr cpsIfMultiVlanTable

Each entry in this table represents port-security information such as
the maximum value of secured mac address allowed, the current number
of secure mac address applied on a VLAN that is allowed on multi-vlan
interface as well as a mechanism to clear the secure mac address on
such VLANs.

=cut

has_table cpsIfMultiVlanTable => (
    oid     => '1.2.5',
    columns => {
        cpsIfMultiVlanIndex              => 1,
        cpsIfMultiVlanMaxSecureMacAddr   => 2,
        cpsIfMultiVlanSecureMacAddrCount => 3,
        cpsIfMultiVlanClearSecureMacAddr => 4,
        cpsIfMultiVlanRowStatus          => 5,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

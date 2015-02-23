package SNMP::Insight::MIB::BGP4;

#ABSTRACT: Support for data in BGP4 MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

with 'SNMP::Insight::MIB';

mib_oid '1.3.6.1.2.1.15';
mib_name 'BGP4-MIB';

has_table "bgpPeerTable" => (
    oid     => "3",
    index   => "",
    columns => {
        bgpPeerIdentifier                    => 1,
        bgpPeerState                         => 2,
        bgpPeerAdminStatus                   => 3,
        bgpPeerNegotiatedVersion             => 4,
        bgpPeerLocalAddr                     => 5,
        bgpPeerLocalPort                     => 6,
        bgpPeerRemoteAddr                    => 7,
        bgpPeerRemotePort                    => 8,
        bgpPeerRemoteAs                      => 9,
        bgpPeerInUpdates                     => 10,
        bgpPeerOutUpdates                    => 11,
        bgpPeerInTotalMessages               => 12,
        bgpPeerOutTotalMessages              => 13,
        bgpPeerLastError                     => 14,
        bgpPeerFsmEstablishedTransitions     => 15,
        bgpPeerFsmEstablishedTime            => 16,
        bgpPeerConnectRetryInterval          => 17,
        bgpPeerHoldTime                      => 18,
        bgpPeerKeepAlive                     => 19,
        bgpPeerHoldTimeConfigured            => 20,
        bgpPeerKeepAliveConfigured           => 21,
        bgpPeerMinASOriginationInterval      => 22,
        bgpPeerMinRouteAdvertisementInterval => 23,
        bgpPeerInUpdateElapsedTime           => 24,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

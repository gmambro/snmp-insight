package SNMP::Insight::MIB::IP;

#ABSTRACT: Support for data in IP-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

with 'SNMP::Insight::MIB';

mib_oid '1.3.6.1.2.1.4';
mib_name 'IP-MIB';

has_scalar 'ipForwarding' => (
    oid    => 1,
    munger => 'munge_forwarding',
);

has_table 'ipRouteTable' => (
    oid     => '21',
    index   => 'ipRouteDest',
    columns => {
        ipRouteDest    => 1,
        ipRouteIfIndex => 2,
        ipRouteMetric1 => 3,
        ipRouteMetric2 => 4,
        ipRouteMetric3 => 5,
        ipRouteMetric4 => 6,
        ipRouteNextHop => 7,
        ipRouteType    => [ 8, 'munge_routeType' ],
        ipRouteProto   => [ 9, 'munge_routeProtocol' ],
        ipRouteAge     => 10,
        ipRouteMask    => 11,
        ipRouteMetric5 => 12,
        ipRouteInfo    => 13,
    }
);

has_table 'ipNetToMediaTable' => (
    oid     => '22',
    index   => '',
    columns => {
        ipNetToMediaPhysAddress => [ 2, 'munge_macaddress' ],
        ipNetToMediaNetAddress  => 3,
        ipNetToMediaType        => [ 4, 'munge_arpEntryType' ],
    }
);

has_scalar 'ipv6IpForwarding' => (
    oid    => 25,
    munger => 'munge_forwarding',
);

sub munge_forwarding {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'forwarding',
        2 => 'notForwarding'
    );
    return $ENUM{$val};
}

sub munge_routeType {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'other',
        2 => 'invalid',
        3 => 'direct',
        4 => 'indirect'
    );
    return $ENUM{$val};
}

sub munge_routeProtocol {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1  => 'other',
        2  => 'local',
        3  => 'netmgmt',
        4  => 'icmp',
        5  => 'egp',
        6  => 'ggp',
        7  => 'hello',
        8  => 'rip',
        9  => 'is-is',
        10 => 'es-is',
        11 => 'ciscoIgrp',
        12 => 'bbnSpfIgp',
        13 => 'ospf',
        14 => 'bgp',
    );
    return $ENUM{$val};
}

sub munge_arpEntryType {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1 => 'other',
        2 => 'invalid',
        3 => 'dynamic',
        4 => 'static'
    );
    return $ENUM{$val};
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

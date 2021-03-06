package SNMP::Insight::MIB::IFMIB;

#ABSTRACT: Support for data in IF-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

with 'SNMP::Insight::MIB';

mib_oid '1.3.6.1.2.1.31';
mib_name 'IF-MIB';

has_scalar 'ifNumber' => ( oid => ".1.3.6.1.2.1.2.1" );

has_table 'ifTable' => (
    oid     => ".1.3.6.1.2.1.2.2",
    index   => 'ifIndex',
    columns => {
        'ifIndex'           => 1,
        'ifDescr'           => 2,
        'ifType'            => 3,
        'ifMtu'             => 4,
        'ifSpeed'           => 5,
        'ifPhysAddress'     => [ 6, 'munge_macaddress' ],
        'ifAdminStatus'     => 7,
        'ifOperStatus'      => 8,
        'ifLastChange'      => 9,
        'ifInOctets'        => 10,
        'ifInUcastPkts'     => 11,
        'ifInNUcastPkts'    => 12,
        'ifInDiscards'      => 13,
        'ifInErrors'        => 14,
        'ifInUnknownProtos' => 15,
        'ifOutOctets'       => 16,
        'ifOutUcastPkts'    => 17,
        'ifOutNUcastPkts'   => 18,
        'ifOutDiscards'     => 19,
        'ifOutErrors'       => 20,
        'ifOutQLen'         => 21,
        'ifSpecific'        => 22,
    }
);

has_table "ifXTable" => (
    oid     => "1.1",
    index   => "ifIndex",
    columns => {
        'ifName'                     => 1,
        'ifInMulticastPkts'          => 2,
        'ifInBroadcastPkts'          => 3,
        'ifOutMulticastPkts'         => 4,
        'ifOutBroadcastPkts'         => 5,
        'ifHCInOctets'               => 6,
        'ifHCInUcastPkts'            => 7,
        'ifHCInMulticastPkts'        => 8,
        'ifHCInBroadcastPkts'        => 9,
        'ifHCOutOctets'              => 10,
        'ifHCOutUcastPkts'           => 11,
        'ifHCOutMulticastPkts'       => 12,
        'ifHCOutBroadcastPkts'       => 13,
        'ifLinkUpDownTrapEnable'     => 14,
        'ifHighSpeed'                => 15,
        'ifPromiscuousMode'          => 16,
        'ifConnectorPresent'         => 17,
        'ifAlias'                    => 18,
        'ifCounterDiscontinuityTime' => 19,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

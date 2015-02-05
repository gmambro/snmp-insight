package SNMP::Easy::MIB::CISCO_CDP;

#ABSTRACT: Support for data in CISCO-CDP-MIB

use Moose::Role;

#VERSION:

use SNMP::Easy::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Easy::MIB';

mib_oid "1.3.6.1.4.1.9.9.23";

mib_name "CISCO-CDP-MIB";

has_table 'cdpCacheTable' => (
    oid     => '1.2.1',
    columns => {
        "cdpCacheAddress"    => [ '4', 'ipaddress' ],
        "cdpCacheDevicePort" => '7',
        "cdpCacheDeviceId"   => '6',
        "cdpCacheSysName"    => '17',
    };
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

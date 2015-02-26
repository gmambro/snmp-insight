package SNMP::Insight::MIB::Cisco_CDP;

#ABSTRACT: Support for data in CISCO-CDP-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.9.9.23";
mib_name "CISCO-CDP-MIB";

has_scalar 'cdpDeviceId' => (
	oid => '1.3.4'
);

has_table 'cdpCacheTable' => (
    oid     => '1.2.1',
    index   => 'cdpCacheAddress',
    columns => {
    	"cdpCacheIfIndex"	    => '1',
    	"cdpCacheAddressType"   => [ '3', 'munge_addrtype'],
        "cdpCacheAddress"       => [ '4', 'munge_ipaddress' ],
        "cdpCacheVersion"       => '5',
        "cdpCacheDeviceId"      => '6',
        "cdpCacheDevicePort"    => '7',
        "cdpCachePlatform"	    => '8',
        "cdpCacheCapabilities"  => ['9', 'munge_caps'],
        "cdpCacheVTPMgmtDomain" => '10',
        "cdpCacheNativeVLAN"    => '11',
        "cdpCacheDuplex"	    => '12',
        "cdpCacheSysName"       => '17',
        "cdpCacheLastChange"    => '24',

    }
);

=func munge_addrtype

Munge enumeration for C<cdpCacheAddressType> in C<CISCO-TC-MIB>. 

=cut

sub munge_addrtype {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1     => 'ip',
        2     => 'decnet',
        3     => 'pup',
        4     => 'chaos',
        5     => 'xns',
        6     => 'x121',
        7     => 'appletalk',
        8     => 'clns',
        9     => 'lat',
        10    => 'vines',
        11    => 'cons',
        12    => 'apollo',
        13    => 'stun',
        14    => 'novell',
        15    => 'qllc',
        16    => 'snapshot',
        17    => 'atmIlmi',
        18    => 'bstun',
        19    => 'x25pvc',
        20    => 'ipv6',
        21    => 'cdm',
        22    => 'nbf',
        23    => 'bpxIgx',
        24    => 'clnsPfx',
        25    => 'http',
        65535 => 'unknown',
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

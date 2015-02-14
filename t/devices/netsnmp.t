use strict;
use warnings FATAL => 'all';
use Test::More;

use lib 't/lib';
use MockSNMP;

use SNMP::Insight::Classifier;
use SNMP::Insight::Device;

{
    my $session = MockSNMP->new( filename => "t/devices/samples/linux.txt" );
    my $device = SNMP::Insight::Device->new( session => $session );
    my $classifier = SNMP::Insight::Classifier->new( device => $device );
    is( $classifier->classify, "NetSNMP", "Linux NetSNMP" );

    $device = SNMP::Insight::open( session => $session );

    is( $device->vendor, "NetSNMP", "Vendor" );
    is( $device->ifTable->{1}->{ifDescr}, "lo" );
    is( $device->ifTable->{1}->{ifType},  "24" );

}

done_testing();

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

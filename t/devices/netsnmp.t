use strict;
use warnings FATAL => 'all';
use Test::More;

use lib 't/lib';
use MockSNMP;

use SNMP::Easy::Classifier;
use SNMP::Easy::Device;

{
    my $session =
      MockSNMP->new( filename => "t/devices/samples/linux.txt" );
    my $device = SNMP::Easy::Device->new( session => $session );
    my $classifier = SNMP::Easy::Classifier->new( device => $device );
    is( $classifier->classify, "NetSNMP", "Linux NetSNMP" );
}

done_testing();

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

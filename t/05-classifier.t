use strict;
use warnings FATAL => 'all';
use Test::More;

use lib 't/lib';
use MockSNMP;

BEGIN {
    use_ok("SNMP::Insight::Classifier");
}

{
    my $session = MockSNMP->new(
        data => {
            '1.3.6.1.2.1.1.1.0' =>
              'Linux centos7.localdomain 3.10.0-123.20.1.el7.x86_64 #1 SMP Thu Jan 29 18:05:33 UTC 2015 x86_64',
            '1.3.6.1.2.1.1.2.0' => '.1.3.6.1.4.1.8072.3.2.10',
        }
    );

    my $device = SNMP::Insight::Device->new( session => $session );
    my $classifier = SNMP::Insight::Classifier->new( device => $device );
    is( $classifier->classify(), 'NetSNMP' );
}

done_testing;

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

use strict;
use warnings FATAL => 'all';
use Test::More;

use lib 't/lib';

BEGIN {
    use_ok('SNMP::Insight::Device::Fortinet');
}

use MockSNMP;
use SNMP::Insight;
use SNMP::Insight::Classifier;
use SNMP::Insight::Device;

done_testing();

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

use_ok 'SNMP::Insight::MIB::SNMPv2';
use_ok 'SNMP::Insight::MIB::IFMIB';
use_ok 'SNMP::Insight::MIB::UCD';

done_testing;

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

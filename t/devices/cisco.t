use strict;
use warnings FATAL => 'all';
use Test::More;

use lib 't/lib';

BEGIN {
    use_ok('SNMP::Insight::Device::Cisco');

    use_ok('SNMP::Insight::Device::Cisco::Airespace');
    use_ok('SNMP::Insight::Device::Cisco::Aironet');
    use_ok('SNMP::Insight::Device::Cisco::AironetIOS');
    use_ok('SNMP::Insight::Device::Cisco::C1900');
    use_ok('SNMP::Insight::Device::Cisco::C2900');
    use_ok('SNMP::Insight::Device::Cisco::C3550');
    use_ok('SNMP::Insight::Device::Cisco::C4000');
    use_ok('SNMP::Insight::Device::Cisco::C6500');
    use_ok('SNMP::Insight::Device::Cisco::Catalyst');
    use_ok('SNMP::Insight::Device::Cisco::FWSM');
    use_ok('SNMP::Insight::Device::Cisco::Nexus');
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


package SNMP::Insight::MIB::EtherLike;

#ABSTRACT: Support for data in EtherLike MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.2.1.10";
mib_name "EtherLike-MIB";

has_table 'dot3StatsTable' => (
    oid     => '7.2',
    columns => {
        dot3StatsIndex                     => 1,
        dot3StatsAlignmentErrors           => 2,
        dot3StatsFCSErrors                 => 3,
        dot3StatsSingleCollisionFrames     => 4,
        dot3StatsMultipleCollisionFrames   => 5,
        dot3StatsSQETestErrors             => 6,
        dot3StatsDeferredTransmissions     => 7,
        dot3StatsLateCollisions            => 8,
        dot3StatsExcessiveCollisions       => 9,
        dot3StatsInternalMacTransmitErrors => 10,
        dot3StatsCarrierSenseErrors        => 11,
        dot3StatsFrameTooLongs             => 13,
        dot3StatsInternalMacReceiveErrors  => 16,
        dot3StatsEtherChipSet              => 17,
        dot3StatsSymbolErrors              => 18,
        dot3StatsDuplexStatus              => 19,
        dot3StatsRateControlAbility        => 20,
        dot3StatsRateControlStatus         => 21,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

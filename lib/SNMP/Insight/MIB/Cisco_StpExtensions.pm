package SNMP::Insight::MIB::Cisco_StpExtensions;

#ABSTRACT: Support for data in CISCO-STP-EXTENSIONS-MIB

use Moose::Role;

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB';

mib_name 'CISCO-STP-EXTENSIONS-MIB';
mib_oid '1.3.6.1.4.1.9.9.82';

has_scalar stpxSpanningTreeType => (
    oid    => '1.6.1',
    munger => 'munge_stpx_sp_type',
);

sub munge_stpx_sp_type {
    my $val = shift;
    $val or return '';
    my %VALUES = (
        1 => 'pvstPlus',
        2 => 'mistp',
        3 => 'mistpPvstPlus',
        4 => 'mst',
        5 => 'rapidPvstPlus',
    );
    return $VALUES{$val} || '';
}

has_table stpxRootGuardConfigTable => (
    oid     => '1.5.1',
    index   => 'stpxRootGuardConfigPortIndex',
    columns => {
        stpxRootGuardConfigPortIndex => 1,
        stpxRootGuardConfigEnabled   => 2,
    }
);

has_table stpxSMSTPortTable => (
    oid     => '1.14.7',
    columns => {
        stpxSMSTPortIndex             => 1,
        stpxSMSTPortStatus            => 2,
        stpxSMSTPortAdminHelloTime    => 3,
        stpxSMSTPortConfigedHelloTime => 4,
        stpxSMSTPortOperHelloTime     => 5,
        stpxSMSTPortAdminMSTMode      => 6,
        stpxSMSTPortOperMSTMode       => 7,

    },
);

has_table stpxLoopGuardConfigTable => (
    oid     => '1.8.1',
    columns => {
        stpxLoopGuardConfigPortIndex => 1,
        stpxLoopGuardConfigEnabled   => 2,
        stpxLoopGuardConfigMode      => 3,
    },
);

has_table stpxFastStartPortTable => (
    oid     => '1.9.3',
    columns => {
        stpxFastStartPortIndex          => 1,
        stpxFastStartPortEnable         => 2,
        stpxFastStartPortMode           => 3,
        stpxFastStartPortBpduGuardMode  => 4,
        stpxFastStartPortBpduFilterMode => 5,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight::MIB::Cisco_VTP;

#ABSTRACT: Support for data in CISCO-VTP-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.9.9.46";

mib_name "CISCO-VTP-MIB";

has_scalar 'vtpVersion' => ( oid => '1.1.1', );

has_scalar 'vtpMaxVlanStorage' => ( oid => '1.1.2', );

# This table contains information on the VLANs which currently exist.
has_table 'vtpVlanTable' => (
    oid     => '1.3.1',
    index   => 'vtpVlanIndex',
    columns => {
        vtpVlanIndex     => 1,
        vtpVlanState     => [2, 'munge_state' ],
        vtpVlanType      => 3,
        vtpVlanName      => 4,
        vtpVlanMtu       => 5,
        vtpVlanDot10Said => 6,
        vtpVlanTranslationalVlan1 => 11,
        vtpVlanTranslationalVlan2 => 12,
        vtpVlanTypeExt   => 17,
        vtpVlanIfIndex   => 18
    },
);

sub munge_state {
    my $val = shift;
    $val or return;
    my %ENUM = (
        1     => 'operational',
        2     => 'suspended',
        3     => 'mtuTooBigForDevice',
        4     => 'mtuTooBigForTrunk',
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

package SNMP::Insight::MIB::Cisco_RTTMON;

#ABSTRACT: Support for data in CISCO-RTTMON-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.9.9.42";
mib_name "CISCO-RTTMON-MIB";

has_scalar rttMonCtrlAdminTable => (
    oid     => '1.2.1',
    columns => {
        rttMonCtrlAdminIndex      => 1,
        rttMonCtrlAdminOwner      => 2,
        rttMonCtrlAdminTag        => 3,
        rttMonCtrlAdminRttType    => 4,
        rttMonCtrlAdminThreshold  => 5,
        rttMonCtrlAdminFrequency  => 6,
        rttMonCtrlAdminTimeout    => 7,
        rttMonCtrlAdminVerifyData => 8,
        rttMonCtrlAdminStatus     => 9,
        rttMonCtrlAdminNvgen      => 10,
        rttMonCtrlAdminGroupName  => 11,
    }
);

has_table rttMonLatestRttOperTable => (
    oid     => '1.2.10',
    columns => {
        rttMonLatestRttOperCompletionTime    => 1,
        rttMonLatestRttOperSense             => 2,
        rttMonLatestRttOperApplSpecificSense => 3,
        rttMonLatestRttOperSenseDescription  => 4,
        rttMonLatestRttOperTime              => 5,
        rttMonLatestRttOperAddress           => 6,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight::MIB::OSPF;

#ABSTRACT: Support for data in BGP4 MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

with 'SNMP::Insight::MIB';

mib_oid '1.3.6.1.2.1.14';
mib_name 'OSPF-MIB';

has_table "ospfIfTable" => (
    oid     => "7",
    columns => {
        ospfIfIpAddress                => 1,
        ospfAddressLessIf              => 2,
        ospfIfAreaId                   => 3,
        ospfIfType                     => 4,
        ospfIfAdminStat                => 5,
        ospfIfRtrPriority              => 6,
        ospfIfTransitDelay             => 7,
        ospfIfRetransInterval          => 8,
        ospfIfHelloInterval            => 9,
        ospfIfRtrDeadInterval          => 10,
        ospfIfPollInterval             => 11,
        ospfIfState                    => 12,
        ospfIfDesignatedRouter         => 13,
        ospfIfBackupDesignatedRouter   => 14,
        ospfIfEvents                   => 15,
        ospfIfAuthKey                  => 16,
        ospfIfStatus                   => 17,
        ospfIfMulticastForwarding      => 18,
        ospfIfDemand                   => 19,
        ospfIfAuthType                 => 20,
        ospfIfLsaCount                 => 21,
        ospfIfLsaCksumSum              => 22,
        ospfIfDesignatedRouterId       => 23,
        ospfIfBackupDesignatedRouterId => 24,
    }
);

has_table "ospfNbrTable" => (
    oid     => "10",
    columns => {
        ospfNbrIpAddr                  => 1,
        ospfNbrAddressLessIndex        => 2,
        ospfNbrRtrId                   => 3,
        ospfNbrOptions                 => 4,
        ospfNbrPriority                => 5,
        ospfNbrState                   => 6,
        ospfNbrEvents                  => 7,
        ospfNbrLSRetransQLen           => 8,
        ospfNBMANbrStatus              => 9,
        ospfNbmaNbrPermanence          => 10,
        ospfNbrHelloSuppressed         => 11,
        ospfNbrRestartHelperStatus     => 12,
        ospfNbrRestartHelperAge        => 13,
        ospfNbrRestartHelperExitReason => 14,
    },
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

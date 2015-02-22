package SNMP::Insight::MIB::HostResources;

#ABSTRACT: Support for data in UCD MIB

use Moose::Role;

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

#VERSION:

mib_oid '1.3.6.1.2.1.25';
mib_name 'HOST-RESOURCES-MIB';

with 'SNMP::Insight::MIB';

has_scalar 'hrSystemUptime' => (
    oid => '1.1',
);

has_scalar 'hrSystemNumUsers' => (
    oid => '1.5',
);

has_scalar 'hrSystemProcesses' => (
    oid => '1.6',
);

has_table 'hrStorageTable' => (
    oid     => '2.3',
    index   => 'hrStorageIndex',
    columns => {
        'hrStorageIndex'              => 1,
        'hrStorageType'               => 2,
        'hrStorageAllocationUnits'    => 3,
        'hrStorageSize'               => 4,
        'hrStorageUsed'               => 5,
        'hrStorageAllocationFailures' => 6,
    },
);

has_table 'hrDeviceTable' => (
    oid     => '3.2',
    index   => 'hrDeviceIndex',
    columns => {
        'hrDeviceIndex'  => 1,
        'hrDeviceType'   => 2,
        'hrDeviceDescr'  => 3,
        'hrDeviceID'     => 4,
        'hrDeviceStatus' => [ 5, 'munge_device_status' ],
        'hrDeviceErrors' => 6,
    },
);

has_table 'hrProcessorTable' => (
    oid     => '3.2',
    index   => 'hrDeviceIndex',
    columns => {
        'hrProcessorFrwID' => 1,
        'hrProcessorLoad'  => 2,
    },
);

has_table 'hrDiskStorageTable' => (
    oid     => '3.6',
    index   => 'hrDiskStorageAccess',
    columns => {
        'hrDiskStorageAccess'    => 1,
        'hrDiskStorageMedia'     => 2,
        'hrDiskStorageRemoveble' => 3,
        'hrDiskStorageCapacity'  => 4,
    },
);

#TODO hrPartitionTable
#TODO hrFSTable

has_table 'hrSWRunTable' => (
    oid     => '4.2',
    index   => 'hrSWRunIndex',
    columns => {
        'hrSWRunIndex'      => 1,
        'hrSWRunName'       => 2,
        'hrSWRunID'         => 3,
        'hrSWRunPath'       => 4,
        'hrSWRunParameters' => 5,
        'hrSWRunType'       => 6,
        'hrSWRunStatus'     => 7,

    },
);

# TODO hrSWRunPerl

has_table 'hrSWInstalledTable' => (
    oid     => '6.3',
    index   => 'hrSWInstalledIndex',
    columns => {
        'hrSWInstalledIndex' => 1,
        'hrSWInstalledName'  => [2, 'munge_sw_installed_name'],
        'hrSWInstalledID'    => 3,
        'hrSWInstalledType'  => 4,
        'hrSWInstalledDate'  => [ 5, 'munge_sw_installed_date' ],
    },
);

=func munge_device_status

Convert device status to a string like unknown running warning testing down.

=cut

sub munge_device_status {
    my $val   = shift;
    my @stati = qw(INVALID unknown running warning testing down);
    return $stati[$val];
}

=func munge_installed_date

Convert hrSWInstalledDate to a human readble date time.

=cut

sub munge_sw_installed_date {
    my $val = shift;

    my ( $y, $m, $d, $hour, $min, $sec ) = unpack( 'n C6 a C2', $val );

    return "$y-$m-$d $hour:$min:$sec";

}

=func munge_sw_installed_name

Clean hrSWInstalledName

=cut

sub munge_sw_installed_name {
    my $val = shift;
    $val =~ s/^"//o;
    $val =~ s/"$//o;
    return $val;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


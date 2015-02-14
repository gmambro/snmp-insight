package SNMP::Easy::MIB::HostResources;

#ABSTRACT: Support for data in UCD MIB

use Moose::Role;

use SNMP::Easy::Moose::MIB;
use namespace::autoclean;

#VERSION:

mib_oid '1.3.6.1.2.1.25';
mib_name 'HOST-RESOURCES-MIB';

with 'SNMP::Easy::MIB';

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
    oid => '2.3.1',
    index => 'hrStorageIndex',
    columns => {
	'hrStorageIndex' => 1,
	'hrStorageType' => 2,
	'hrStorageAllocationUnits' => 3,
	'hrStorageSize' => 4,
	'hrStorageUsed' => 5,
	'hrStorageAllocationFailures' => 6,	
    },
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

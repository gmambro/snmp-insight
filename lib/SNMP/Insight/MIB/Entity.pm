package SNMP::Insight::MIB::Entity;

#ABSTRACT: Support for data in ENTITY MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

with 'SNMP::Insight::MIB';

mib_oid '1.3.6.1.2.1.47';
mib_name 'ENTITY-MIB';

has_table "entityPhysical" => (
    oid     => "1.1",
    index   => "entPhysicalIndex",
    columns => {
        entPhysicalIndex        => 1,
        entPhysicalDescr        => 2,
        entPhysicalVendorType   => 3,
        entPhysicalContainedIn  => 4,
        entPhysicalClass        => 5,
        entPhysicalParentRelPos => 6,
        entPhysicalName         => 7,
        entPhysicalHardwareRev  => 8,
        entPhysicalFirmwareRev  => 9,
        entPhysicalSoftwareRev  => 10,
        entPhysicalSerialNum    => 11,
        entPhysicalMfgName      => 12,
        entPhysicalModelName    => 13,
        entPhysicalAlias        => 14,
        entPhysicalAssetID      => 15,
        entPhysicalIsFRU        => 16,
        entPhysicalMfgDate      => 17,
        entPhysicalUris         => 18,
    }
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

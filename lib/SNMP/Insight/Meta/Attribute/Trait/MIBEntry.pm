package SNMP::Insight::Meta::Attribute::Trait::MIBEntry;

#ABSTRACT: Attribute trait for attributes derived from MIBs

use Moose::Role;
use Moose::Util::TypeConstraints;

#VERSION:

Moose::Util::meta_attribute_alias('MIBEntry');

enum 'MIBEntryType', [qw(scalar table column)];

=attr oid

The oid in the MIB.

=cut

has oid => (
    is        => 'rw',
    isa       => 'Str',
    required  => 1,
    predicate => 'has_oid',
);

=attr munger

The code reference used, if present, to parse the value retrieved from the device.

=cut

has munger => (
    is        => 'rw',
    isa       => 'CodeRef',
    required  => 0,
    predicate => 'has_munger',
);

=attr extras

A hash of extra stuff useful to make a munger parametric.

=cut

has extras => (
    is        => 'rw',
    isa       => 'HashRef',
    required  => 0,
    predicate => 'has_extras',
);

=attr entry_type

One of scalar, table, column.

=cut

has entry_type => (
    is       => 'rw',
    isa      => 'MIBEntryType',
    required => 1,
);

=method is_scalar

Return true if it's a scalar entry

=cut

sub is_scalar {
    return $_[0]->entry_type eq 'scalar';
}

=method is_table

Return true if it's a table entry

=cut

sub is_table {
    return $_[0]->entry_type eq 'table';
}

=method is_column

Return true if it's a column entry

=cut

sub is_column {
    return $_[0]->entry_type eq 'column';
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

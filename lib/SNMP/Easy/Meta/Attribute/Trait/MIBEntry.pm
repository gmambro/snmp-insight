package SNMP::Easy::Meta::Attribute::Trait::MIBEntry;

#ABSTRACT: Attribute trait for attributes derived from MIBs

use Moose::Role;
use Moose::Util::TypeConstraints;

#VERSION:

Moose::Util::meta_attribute_alias('MIBEntry');

enum 'MIBEntryType', [qw(scalar table column)];

has oid => (
    is        => 'rw',
    isa       => 'Str',
    required  => 1,
    predicate => 'has_oid',
);

has munger => (
    is        => 'rw',
    isa       => 'CodeRef',
    required  => 0,
    predicate => 'has_munger',
);

has entry_type => (
    is        => 'rw',
    isa       => 'MIBEntryType',
    required  => 1,    
);

sub is_scalar {
    return $_[0]->entry_type eq 'scalar';
}

sub is_table {
    return $_[0]->entry_type eq 'table';
}

sub is_column {
    return $_[0]->entry_type eq 'table';
}
    
1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

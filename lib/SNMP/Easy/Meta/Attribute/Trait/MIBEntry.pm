package SNMP::Easy::Meta::Attribute::Trait::MIBEntry;

#ABSTRACT: Attribute trait for attributes derived from MIBs

use Moose::Role;

#VERSION:

Moose::Util::meta_attribute_alias('MIBEntry');

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

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

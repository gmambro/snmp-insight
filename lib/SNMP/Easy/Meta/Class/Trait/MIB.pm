package SNMP::Easy::Meta::Class::Trait::MIB;

#ABSTRACT: meta class trait for MIBs roles

use Moose::Role;

#VERSION:

Moose::Util::meta_class_alias('MIB');

has mib_name => (
    is  => 'rw',
    isa => 'Str',
);

has mib_oid => (
    is  => 'rw',
    isa => 'Str',
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


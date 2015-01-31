#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    plan tests => 5;

    use_ok('SNMP::Easy::Meta::Class::Trait::MIB');
}

{

    package TestMibTrait;
    use Moose -traits => 'MIB';

    __PACKAGE__->meta->mib_oid('1.2.3');
    __PACKAGE__->meta->mib_name('TEST-MIB');
}

ok( TestMibTrait->meta->can('mib_oid') );
is( TestMibTrait->meta->mib_oid, '1.2.3' );

ok( TestMibTrait->meta->can('mib_name') );
is( TestMibTrait->meta->mib_name, 'TEST-MIB' );

done_testing;

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


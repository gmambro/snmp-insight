use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    use_ok 'SNMP::Easy::MIB';
}

{
    package MockSession;
    use Moose;

    sub get_scalar {
	my ($self, $oid) = @_;
	return $oid;
    }
    
    package FooMIB;
    use Moose::Role;
    use SNMP::Easy::MIB::Mooseish;
    with 'SNMP::Easy::MIB';

    mib_oid "1.1.1";
    has_scalar "fooScalar" => ( oid => '.1' );

    package BaseDevice;
    use Moose;
    use MockSession;
 
    has session => (
	isa => 'MockSession',
	is => 'ro',
	default => sub { MockSession->new() }
    );   
    
    package TestDevice;
    use Moose;
    extends 'BaseDevice';
    with 'FooMIB';

}

use_ok 'TestDevice';
{
    my $c = TestDevice->new();
    ok($c, 'Creating test device');
    ok($c->meta->has_attribute('fooScalar'), 'create accessor for a MIB scalar');
    cmp_ok($c->fooScalar, 'eq', '1.1.1.1', "call accessor");
}

{
    package BarMIB;
    use Moose::Role;
    use SNMP::Easy::MIB::Mooseish;
    with 'SNMP::Easy::MIB';
    
    mib_oid "1.1.2";
    has_scalar "barScalar" => ( oid => '.2' );

    package TestDevice2;
    use Moose;
    extends 'BaseDevice';
    with 'FooMIB', 'BarMIB';
}	

{
    my $c = TestDevice2->new();
    ok($c, 'Creating test device with multiple MIB');
    ok($c->meta->has_attribute('fooScalar'), 'create accessor from first MIB1');
    ok($c->meta->has_attribute('barScalar'), 'create accessor from second MIB2');	
    cmp_ok($c->fooScalar, 'eq', '1.1.1.1', "call accessor first MIB");
    cmp_ok($c->barScalar, 'eq', '1.1.2.2', "call accessor second MIB");
}

done_testing;

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

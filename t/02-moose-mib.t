use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    use_ok 'SNMP::Insight::MIB';
}

{

    package MockSession;
    use Moose;

    sub get_scalar {
        my ( $self, $oid ) = @_;
        return $oid;
    }

    sub get_subtree {
        my ( $self, $oid ) = @_;

        $oid eq "1.1.1.2.1.1"
          and return [
            [ "$oid.1", "1" ],
            [ "$oid.2", "2" ]
          ];
        $oid eq "1.1.1.2.1.2"
          and return [
            [ "$oid.1", "A" ],
            [ "$oid.2", "B" ],
          ];

        $oid eq "1.1.1.3.1.1"
          and return [
            [ "$oid.1.2.3.4", "A1" ],
            [ "$oid.5.6.7.8", "B1" ],
          ];
        $oid eq "1.1.1.3.1.2"
          and return [
            [ "$oid.1.2.3.4", "A2" ],
            [ "$oid.5.6.7.8", "B2" ],
          ];

        die "Test is wrong";
    }

    package FooMIB;
    use Moose::Role;
    use SNMP::Insight::Moose::MIB;
    with 'SNMP::Insight::MIB';

    mib_oid "1.1.1";
    has_scalar "fooScalar" => ( oid => '1' );

    has_table "fooGrockTable" => (
        oid     => '2',
        index   => 'fooGrockIndex',
        columns => {
            fooGrockIndex => 1,
            fooGrockValue => 2,
        },
    );

    has_table "fooMooTable" => (
        oid             => '3',
        index_generator => \&munge_moo,
        columns         => {
            fooMooGree => 1,
            fooMooGroo => 2,
        },
    );

    sub munge_moo {
        my $val = shift;
        my @f = split /\./, $val;
        return "$f[0]-$f[1]", "$f[2]-$f[3]";
    }

    package BaseDevice;
    use Moose;
    use MockSession;

    has session => (
        isa     => 'MockSession',
        is      => 'ro',
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
    ok( $c, 'Creating test device' );
    ok(
        $c->meta->has_attribute('fooScalar'),
        'create accessor for a MIB scalar'
    );
    cmp_ok( $c->fooScalar, 'eq', '1.1.1.1', "call accessor" );

    ok(
        $c->meta->has_attribute('fooGrockTable'),
        'create accessor for a MIB tale'
    );

    ok(
        $c->meta->has_attribute('fooGrockIndex'),
        'create accessor for a table column'
    );

    cmp_ok( $c->fooGrockValue->{1}, 'eq', "A", "Table value 1" );
    cmp_ok( $c->fooGrockValue->{2}, 'eq', "B", "Table value 2" );

    ok(
        $c->meta->has_attribute('fooMooTable_index'),
        'create accessor for a table generated index'
    );

    ok(
        eq_hash(
            $c->fooMooTable_index, {
                "1.2.3.4" => [ "1-2", "3-4" ],
                "5.6.7.8" => [ "5-6", "7-8" ],
            }
        ),
        "Table2 index munger"
    );

    ok(
        eq_hash(
            $c->fooMooGree, {
                '1.2.3.4' => 'A1',
                '5.6.7.8' => 'B1',
            },
        ),
        "Table2 column 1"
    );

    ok(
        eq_hash(
            $c->fooMooGroo, {
                '1.2.3.4' => 'A2',
                '5.6.7.8' => 'B2',
            },
        ),
        "Table2 column 2"
    );

    ok(
        eq_hash(
            $c->fooMooTable, {
                '1.2.3.4' => {
                    'fooMooTable_index' => [
                        '1-2',
                        '3-4'
                    ],
                    'fooMooGroo' => 'A2',
                    'fooMooGree' => 'A1'
                },
                '5.6.7.8' => {
                    'fooMooTable_index' => [
                        '5-6',
                        '7-8'
                    ],
                    'fooMooGroo' => 'B2',
                    'fooMooGree' => 'B1'
                },
            }
        ),
        "Table2 full table attribute"
    );

}

{

    package BarMIB;
    use Moose::Role;
    use SNMP::Insight::Moose::MIB;
    with 'SNMP::Insight::MIB';

    mib_oid "1.1.2";
    has_scalar "barScalar" => ( oid => '2' );

    package TestDevice2;
    use Moose;
    extends 'BaseDevice';
    with 'FooMIB', 'BarMIB';
}

{
    my $c = TestDevice2->new();
    ok( $c, 'Creating test device with multiple MIB' );
    ok(
        $c->meta->has_attribute('fooScalar'),
        'create accessor from first MIB1'
    );
    ok(
        $c->meta->has_attribute('barScalar'),
        'create accessor from second MIB2'
    );
    cmp_ok( $c->fooScalar, 'eq', '1.1.1.1', "call accessor first MIB" );
    cmp_ok( $c->barScalar, 'eq', '1.1.2.2', "call accessor second MIB" );
}

done_testing;

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Easy::Moose::MIB;

#ABSTRACT: Moose glue to write MIB roles

use Moose;
use Moose::Exporter;
use Carp;

#VERSION:

use SNMP::Easy::Meta::Attribute::Trait::MIBEntry;

Moose::Exporter->setup_import_methods(
    with_meta      => [ 'mib_oid', 'mib_name', 'has_scalar', 'has_table' ],
    role_metaroles => {
        role => ['SNMP::Easy::Meta::Class::Trait::MIB'],
    },
);

sub mib_oid {
    my $meta = shift;
    $meta->mib_oid(shift);
}

sub mib_name {
    my $meta = shift;
    $meta->mib_name(shift);
}

sub has_scalar {
    my ( $meta, $name, %options ) = @_;

    my $oid = $options{oid};
    $oid =~ /^\./ and $oid = $meta->mib_oid . $oid;

    my $munger_code;
    if ( $options{munger} ) {
        $munger_code = _load_munger( $meta, $options{munger} );
    }

    my %attribute_options = (
        traits  => ['MIBEntry'],
        is      => 'ro',
        lazy    => 1,
        oid     => $oid,
        default => sub {
            my $self = shift;
            $self->_mib_read_scalar( $oid, $munger_code );
        },
    );
    $options{munger} and $attribute_options{munger} = $munger_code;

    $meta->add_attribute( $name, %attribute_options );
}

sub has_table {
    my ( $meta, $name, %options ) = @_;

    my $table_oid = $options{oid};
    $table_oid or croak "Table $name has no oid";
    $table_oid =~ /^\./ and $table_oid = $meta->mib_oid . $table_oid;

    my $columns = $options{columns};
    $columns or croak "Table $name has no columns definition";
    while ( my ( $col_name, $col_opts ) = each(%$columns) ) {
        _create_column( $meta, $table_oid, $col_name, $col_opts );
    }

    my $index = $options{index};
    $index or croak "Table $name has no index defined";
    $meta->has_attribute($index)
      or croak "Cannot find index $index for table $name";

    # TODO check index

    $meta->add_attribute(
        $name,

        # is it needed?
        # traits => ['MIBEntry'],

        is   => 'ro',
        lazy => 1,

        default => sub {
            my $self = shift;
            $self->_mib_read_table( $index, [ keys %$columns ] );
        },
    );
}

sub _load_munger {
    my ( $meta, $munger ) = @_;

    # easy case
    return $munger if ref($munger) eq "CODE";

    my $metamethod = $meta->find_method_by_name($munger)
      or croak "No $munger found";
    return $metamethod->body;
}

sub _create_column {
    my ( $meta, $table_oid, $col_name, $col_opts ) = @_;

    ref $col_opts eq 'ARRAY' or $col_opts = [$col_opts];

    my ( $sub_id, $munger ) = @$col_opts;

    my $col_oid = "$table_oid.$sub_id";
    my $munger_code;
    $munger and $munger_code = _load_munger( $meta, $munger );

    my %attribute_options = (
        traits  => ['MIBEntry'],
        is      => 'ro',
        lazy    => 1,
        oid     => $col_oid,
        default => sub {
            my $self = shift;
            $self->_mib_read_tablerow( $col_oid, $munger_code );
        },
    );
    $munger and $attribute_options{munger} = $munger_code;

    $meta->add_attribute( $col_name, %attribute_options );
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

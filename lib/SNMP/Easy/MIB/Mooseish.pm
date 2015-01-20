package SNMP::Easy::MIB::Mooseish;
#ABSTRACT: Moose glue to write MIB roles

use Moose;
use Moose::Exporter;

our $VERSION = '0.0.0';

use SNMP::Easy::Meta::Attribute::Trait::MIBEntry;

Moose::Exporter->setup_import_methods(
    with_meta       => ['mib_oid', 'mib_name', 'has_scalar', 'has_table'],
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
    
    # TODO
    $meta->add_attribute(
	$name,
        traits => ['MIBEntry'],
	is => 'ro',
	lazy => 1,
        oid => $oid,
	default => sub {
	    my $self = shift;
	    $self->_mib_read_scalar(oid => $oid)
	},
    );
}

sub has_table {
    my ( $meta, $name, %options ) = @_;

    my $oid = $options{oid};
    $oid =~ /^\./ and $oid = $meta->mib_oid . $oid;

    my $columns = $options{columns};
    while ( my ($name, $def) = each (%$columns) ) {
        my ($sub_id, $munge);        
        ref $def eq 'ARRAY' ? ($sub_id, $munge) = @$def : $sub_id = $def; 
        my $col_id = "$oid.$sub_id";
        
        $meta->add_attribute(
            $name,
            traits => ['MIBEntry'],
            is => 'ro',
            lazy => 1,
            oid => $col_id,
            default => sub {
                my $self = shift;
                $self->_mib_read_tablerow(oid => $col_id)
            },
        );
    }
}

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

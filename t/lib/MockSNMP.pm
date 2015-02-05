package MockSNMP;

use Moose;

with 'SNMP::Easy::Session';

has _filename => (
    is       => 'ro',
    isa      => 'Str',
    init_arg => 'filename',
);

has _data => (
    is       => 'ro',
    isa      => 'HashRef',
    lazy     => 1,
    builder  => '_load_data',
    init_arg => 'data'
);

has _oids => (
    is      => 'ro',
    isa     => 'ArrayRef',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my @oids = _oid_lex_sort( keys %{ $self->_data } );
        return \@oids;
    }
);

has '+hostname' => ( required => 0 );
has '+version'  => ( required => 0 );

sub _load_data {
    my $self = shift;

    my %data;

    open my $fh, "<", $self->_filename;

    my ( $oid, $type, $value );

    while ( my $line = <$fh> ) {
        if ( $line =~ /^((?:\.\d+)+) = (\w+): (.*)$/ ) {

            # a new entry, check if there is an old one pending
            if ( defined $oid ) {
                $data{$oid} = $value;
            }

            ( $oid, $type, $value ) = ( $1, $2, $3 );
            $oid =~ s/^\.//o;
        }
        else {
            $value .= $line;
        }
    }

    if ( defined $oid ) {
        $data{$oid} = $value;
    }

    close $fh;

    return \%data;
}

sub get_scalar {
    my $self = shift;
    my $oid  = shift;

    $oid .= '.0';
    return $self->_data->{$oid};
}

sub get_subtree {
    my $self     = shift;
    my $root_oid = shift;

    my $result = [];

    foreach my $oid ( $self->_oids ) {
        $oid =~ /^$root_oid/ or next;
        push @$result, [ $oid, $self->_data->{$oid} ];
    }

    return $result;
}

sub _oid_lex_sort {
    return map { $_->[0] }
      sort     { $a->[1] cmp $b->[1] }
      map {
        my $oid = $_;
        $oid =~ s/^\.//;
        $oid =~ s/ /\.0/g;
        [ $_, pack 'N*', split m/\./, $oid ]
      } @_;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

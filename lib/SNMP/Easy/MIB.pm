package SNMP::Easy::MIB;

#ABSTRACT: Base role for MIBs

use Moose::Role;

#VERSION:

use namespace::autoclean;

requires 'session';

sub _mib_read_scalar {
    my ( $self, $oid, $munger ) = @_;

    my $v = $self->session->get_scalar($oid);
    $munger and $v = munger->($v);
    return $v;
}

sub _mib_read_tablerow {
    my ( $self, $oid, $munger ) = @_;

    my $row = $self->session->get_subtree($oid);

    foreach (@$row) {

        # Don't optimize this RE!
        $_->[0] =~ /^$oid\.(.*)/ and $_->[0] = $1;
        $munger                  and $_->[1] = $munger->( $_->[1] );
    }

    return $row;
}

sub _mib_read_table {
    my ( $self, $index, $columns ) = @_;

    my $table = {};

    # TODO index handling
    # if ( ! $self->can($index) ) {
    #    carp "Cannot find index $index";
    # }

    for my $col (@$columns) {
        my $col_values = $self->$col();
        foreach my $pair (@$col_values) {
            $table->{ $pair->[0] }->{$col} = $pair->[1];
        }
    }

    return $table;
}

sub munge_macaddress {
    my $mac = shift;
    $mac or return "";
    $mac = join( ':', map { sprintf "%02x", $_ } unpack( 'C*', $mac ) );
    return $mac if $mac =~ /^([0-9A-F][0-9A-F]:){5}[0-9A-F][0-9A-F]$/i;
    return "ERROR";
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

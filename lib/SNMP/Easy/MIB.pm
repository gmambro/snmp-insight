package SNMP::Easy::MIB;

#ABSTRACT: Base role for MIBs

use Moose::Role;

our $VERSION = '0.0.0';

use namespace::autoclean;

requires 'session';

sub _mib_read_scalar {
    my ( $self, $oid, $munger ) = @_;

    $self->session->get_scalar($oid);
}

sub _mib_read_tablerow {
    my ( $self, $oid, $munger ) = @_;

    my $row = $self->session->get_subtree($oid);

    foreach (@$row) {
        $_->[0] =~ /^$oid\.(.*)/o and $_->[0] = $1;
    }

    return $row;
}

sub _mib_read_table {
    die "Not implemented yet";
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

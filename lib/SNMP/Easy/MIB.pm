package SNMP::Easy::MIB;
#ABSTRACT: Base role for MIBs

use Moose::Role;

our $VERSION = '0.0.0';

use namespace::autoclean;

requires 'session';

sub _mib_read_scalar {
    my ($self, %options) = @_;

    $self->session->get_scalar($options{oid});
}

sub _mib_read_tablerow {
    my ($self, %options) = @_;
    my $oid = $options{oid};
    
    my $row = $self->session->get_subtree($oid);
    
    foreach (@$row) {
        $_->[0] =~ /^$oid\.(.*)/o and $_->[0] = $1;
    }

    return $row;
}

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

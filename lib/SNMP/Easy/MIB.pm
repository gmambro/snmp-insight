package SNMP::Easy::MIB;

#ABSTRACT: Base role for MIBs

use Moose::Role;

#VERSION:

use namespace::autoclean;

requires 'session';

sub _mib_read_scalar {
    my ( $self, $oid, $munger ) = @_;

    my $v = $self->session->get_scalar($oid);
    $munger and $v = $munger->($v);
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

=func munge_bool()

Takes a BOOLEAN and makes it a nop|true|false string

=cut

sub munge_bool {
    my $bool = shift;
    my @ARR  = qw ( nop  false true);

    return $ARR[$bool];
}

=func munge_ipaddress() 

Takes a binary IP and makes it dotted ASCII

=cut

sub munge_ipaddress {
    my $ip = shift;
    return join( '.', unpack( 'C4', $ip ) );
}

=func munge_macaddress()

Takes an octet stream (HEX-STRING) and returns a colon separated ASCII hex
string.

=cut

sub munge_macaddress {
    my $mac = shift;
    $mac or return "";
    $mac = join( ':', map { sprintf "%02x", $_ } unpack( 'C*', $mac ) );
    return $mac if $mac =~ /^([0-9A-F][0-9A-F]:){5}[0-9A-F][0-9A-F]$/i;
    return "ERROR";
}

=func munge_octet2hex()

Takes a binary octet stream and returns an ASCII hex string

=cut

sub munge_octet2hex {
    my $oct = shift;
    return join( '', map { sprintf "%x", $_ } unpack( 'C*', $oct ) );
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight::MIB;

#ABSTRACT: Base role for MIBs

use Moose::Role;
use Carp;

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

    my $ret = {};
    foreach (@$row) {

        # Don't optimize this RE!
        $_->[0] =~ /^$oid\.(.*)/ and $_->[0] = $1;
        $munger                  and $_->[1] = $munger->( $_->[1] );

        $ret->{ $_->[0] } = $_->[1];
    }

    return $ret;
}

sub _mib_read_table {
    my $self = shift;
    my %args = @_;

    my $index = $args{index};
    my $columns = $args{columns} or croak "Missing parameter columns";

    my $table = {};

    # TODO index handling
    # if ( ! $self->can($index) ) {
    #    carp "Cannot find index $index";
    # }

    for my $col (@$columns) {
        my $col_values = $self->$col();
        while ( my ( $k, $v ) = each(%$col_values) ) {
            $table->{$k}->{$col} = $v;
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

=func munge_bits

Takes a 'BITS' field and returns to an ASCII bit string

=cut

sub munge_bits {
    my $bits = shift;
    return unless defined $bits;

    return unpack( "B*", $bits );
}

=func munge_counter64

Return a Math::BigInt object.

=cut

sub munge_counter64 {
    my $counter = shift;
    return unless defined $counter;
    my $bigint = Math::BigInt->new($counter);
    return $bigint;
}

=func munge_ifoperstatus

Munge enumeration for C<ifOperStatus> in C<IF-MIB>. 

=cut

sub munge_ifoperstatus {
    my $val = shift;
    return unless $val;

    my %ifOperStatusMap = (
        '4' => 'unknown',
        '5' => 'dormant',
        '6' => 'notPresent',
        '7' => 'lowerLayerDown'
    );
    return $ifOperStatusMap{$val} || $val;
}

=func munge_port_list

Takes an octet string representing a set of ports and returns a reference
to an array of binary values each array element representing a port. 


=cut

sub munge_port_list {
    my $oct = shift;
    return unless defined $oct;

    my $list = [ split( //, unpack( "B*", $oct ) ) ];

    return $list;
}

=func munge_caps

Takes an octet string and returns an ascii binary string, 7 digits long, MSB.

=cut

sub munge_caps {
    my $caps = shift;
    return unless defined $caps;

    my $bits = substr( unpack( "B*", $caps ), -7 );
    return $bits;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

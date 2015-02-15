package SNMP::Insight::Session::NetSNMP;

#ABSTRACT: Net::SNMP based implementation for SNMP::Insight::Session
use Moose;

#VERSION:

with 'SNMP::Insight::Session';

use Net::SNMP 6.0 qw( :snmp DEBUG_ALL ENDOFMIBVIEW );
use SNMP::Insight 'debug';

has '_driver' => (
    is      => 'ro',
    isa     => 'Object',
    lazy    => 1,
    builder => '_build_driver',
);

sub _build_driver {
    my $self = shift;

    my %options;
    $options{-hostname} = $self->hostname;
    $options{-port}     = $self->port;

    my %version_map = ( 1 => 'snmpv1', '2c' => 'snmpv2c', 3 => 'snmpv3' );
    $options{-version} = $version_map{ $self->version };

    #    $options{-domain}        = $self->domain;
    $options{-timeout} = $self->timeout;
    $options{-retries} = $self->retries;

    $options{-debug} = DEBUG_ALL if SNMP::Insight::debug();

    $options{-localaddr}    = $self->localaddr    if $self->localaddr;
    $options{-localport}    = $self->localport    if $self->localport;
    $options{-community}    = $self->community    if $self->community;
    $options{-username}     = $self->username     if $self->username;
    $options{-authkey}      = $self->authkey      if $self->authkey;
    $options{-authpassword} = $self->authpassword if $self->authpassword;
    $options{-authprotocol} = $self->authproto    if $self->authprotocol;
    $options{-privkey}      = $self->privkey      if $self->privkey;
    $options{-privpassword} = $self->privpassword if $self->privpassword;
    $options{-privprotocol} = $self->privprotocol if $self->privprotocol;

    $options{-translate} = [
        '-all'            => 1,
        '-octetstring'    => 0,
        '-null'           => 1,
        '-timeticks'      => 0,
        '-opaque'         => 1,
        '-nosuchobject'   => 1,
        '-nosuchinstance' => 1,
        '-endofmibview'   => 1,
        '-unsigned'       => 1,
    ];

    return Net::SNMP->session(%options);

}

=method get_scalar($oid)

Implements get_scalar using Net::SNMP session

=cut

sub get_scalar {
    my ( $self, $oid ) = @_;

    my $session = $self->_driver;

    #add istance number to the oid
    $oid .= '.0';

    SNMP::Insight::debug() and print "SNMP::Insight fetching scalar $oid\n";

    my $result = $session->get_request( '-varbindlist' => [$oid] );
    $result or die "SNMP error " . $session->error();

    return $result->{$oid};
}

=method get_subtree($oid)

Implements get_subtree using Net::SNMP session


=cut

sub get_subtree {
    my ( $self, $oid ) = @_;

    my @result;

    my $s = $self->_driver;
    $oid eq '.' and $oid = '0';

    SNMP::Insight::debug() and print "SNMP::Insight fetching subtree $oid\n";

    my $last_oid = $oid;

    if ( $s->version() == SNMP_VERSION_1 ) {

        while ( defined $s->get_next_request( -varbindlist => [$last_oid] ) ) {
            my $returned_oid = ( $s->var_bind_names() )[0];
            if ( !oid_base_match( $last_oid, $returned_oid ) ) {
                last;
            }

            # store into result
            push @result,
              [ $returned_oid, $s->var_bind_list()->{$returned_oid} ];

            $last_oid = $returned_oid;
        }

    }
    else {

      GET_BULK:
        while (
            defined $s->get_bulk_request(
                -maxrepetitions => 25,
                -varbindlist    => [$last_oid]
            )
          )
        {
            my @oids = $s->var_bind_names();

            if ( !scalar @oids ) {
                die('Received an empty varBindList');
            }

            foreach my $returned_oid (@oids) {

                if ( !oid_base_match( $oid, $returned_oid ) ) {
                    last GET_BULK;
                }

                # Make sure we have not hit the end of the MIB.
                if ( $s->var_bind_types()->{$returned_oid} == ENDOFMIBVIEW ) {
                    last GET_BULK;
                }

                push @result,
                  [ $returned_oid, $s->var_bind_list()->{$returned_oid} ];

                $last_oid = $returned_oid;
            }
        }

    }

    return \@result;
}

=head1 SEE ALSO

Session interface L<SNMP::Insight::Session> 

=cut

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

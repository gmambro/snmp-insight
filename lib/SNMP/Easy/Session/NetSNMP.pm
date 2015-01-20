package SNMP::Easy::Session::NetSNMP;
#ABSTRACT: Net::SNMP based implementation for SNMP::Easy::Session
use Moose;

our $VERSION = '0.0.0';

with 'SNMP::Easy::Session';

use Net::SNMP 6.0 qw( :snmp DEBUG_ALL ENDOFMIBVIEW );

sub _build_driver {
    my $self = shift;
    
    my %options;
    $options{-hostname}      = $self->hostname;
    $options{-port}          = $self->port;                               
    $options{-version}       = $self->version;
    #    $options{-domain}        = $self->domain;
    $options{-timeout}       = $self->timeout;
    $options{-retries}       = $self->retries;

    # $options{-translate}     = $self->translate;
    $options{-debug}         = DEBUG_ALL if $ENV{SNMP_EASY_DEBUG};

    $options{-localaddr}     = $self->localaddr     if $self->localaddr;
    $options{-localport}     = $self->localport     if $self->localport;    
    $options{-community}     = $self->community     if $self->community;;
    $options{-username}      = $self->username      if $self->username;
    $options{-authkey}       = $self->authkey       if $self->authkey;
    $options{-authpassword}  = $self->authpassword  if $self->authpassword;
    $options{-authprotocol}  = $self->authproto     if $self->authprotocol;
    $options{-privkey}       = $self->privkey       if $self->privkey;
    $options{-privpassword}  = $self->privpassword  if $self->privpassword;
    $options{-privprotocol}  = $self->privprotocol  if $self->privprotocol;

    return Net::SNMP->session(%options);
}

sub get_scalar {
    my ($self, $oid) = @_;
    
    my $session = $self->_driver;
    
    #add istance number to the oid
    $oid .= '.0';
    
    my $result = $session->get_request( '-varbindlist'  => [$oid] );

    $result or die "SNMP error ".$session->error();
       
    return $result->{$oid};
}

sub get_subtree {
    my ($self, $oid) = @_;

    my @result;
    
    my $s = $self->_driver;
    $oid eq '.' and $oid = '0';
 
    my $last_oid = $oid;
    
    if ($s->version() == SNMP_VERSION_1) {
	
	while (defined $s->get_next_request(-varbindlist => [ $last_oid ])) {
	    my $returned_oid = ($s->var_bind_names())[0];
	    if (!oid_base_match($last_oid, $returned_oid)) {
		last;
	    }

            # store into result
	    push @result, [ $returned_oid, $s->var_bind_list()->{$returned_oid}];

	    $last_oid = $returned_oid;
	}
	
    } else {

      GET_BULK:
	while (defined $s->get_bulk_request(-maxrepetitions => 25,
					    -varbindlist => [$last_oid])) {                                
	    my @oids = $s->var_bind_names();
	    
	    if (!scalar @oids) {
		die('Received an empty varBindList');
	    }
	    
	    foreach my $returned_oid (@oids) {
                
		if (!oid_base_match($oid, $returned_oid)) {
		    last GET_BULK;
		}

                # Make sure we have not hit the end of the MIB.
		if ($s->var_bind_types()->{$returned_oid} == ENDOFMIBVIEW) {
		    last GET_BULK;
		}
                
                push @result, [ $returned_oid, $s->var_bind_list()->{$returned_oid}];
                
		$last_oid = $returned_oid;
	    }
	}
	
    }
    
    return \@result;
}


1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

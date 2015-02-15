package SNMP::Insight::Session;

#ABSTRACT: Role for SNMP client implementantions
use Moose::Role;

#VERSION:

use namespace::autoclean;

use Carp;

use Moose::Util::TypeConstraints;
enum 'SnmpVersion' => [qw(1 2c 3)];
no Moose::Util::TypeConstraints;

=method get_scalar($oid)

Required method. Should return the value at $oid.0.

=method get_subtree($oid)

Required method. Should return all the values at $oid in a list of [ oid, value ] pairs.

=cut

requires
  'get_scalar',
  'get_subtree';


=attr hostname

Required.

=cut

has hostname => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

=attr port

Default 161

=cut

has port => (
    is      => 'ro',
    isa     => 'Int',
    default => '161'
);

=attr localaddr

Optional. Can be used to set local address to bind to.

=

has localaddr => (
    is  => 'ro',
    isa => 'Str',
);

=attr localaddr

Optional. Can be used to set local port to bind to.

=

has localport => (
    is  => 'ro',
    isa => 'Int',
);

=attr version

Required, should be on of "1", "2c", "3".

=cut

has version => (
    is       => 'ro',
    isa      => 'SnmpVersion',
    required => 1,
);

=attr timeout

Transport layer timeout in seconds.

=cut

has 'timeout' => (
    is      => 'ro',
    isa     => 'Int',
    default => 5
);

=attr retries

Number of times to retry sending a SNMP message to the remote host.

=cut

has 'retries' => (
    is      => 'ro',
    isa     => 'Int',
    default => 5
);

=attr community

The SNMP community name to be used for SNMPv1 and SNMPv2c security model.

=cut

has 'community' => (
    is  => 'ro',
    isa => 'Str',
);

=attr username

securityName for SNMPv3

=cut

has 'username' => (
    is  => 'ro',
    isa => 'Str',
);

has 'authkey' => (
    is  => 'ro',
    isa => 'Str',
);

has 'authpassword' => (
    is  => 'ro',
    isa => 'Str',
);

has 'authprotocol' => (
    is  => 'ro',
    isa => 'Str',
);

has 'privkey' => (
    is  => 'ro',
    isa => 'Str',
);

has 'privpassword' => (
    is  => 'ro',
    isa => 'Str',
);

has 'privprotocol' => (
    is  => 'ro',
    isa => 'Str',
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

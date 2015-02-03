package SNMP::Easy::Session;

#ABSTRACT: Role for SNMP client implementantions
use Moose::Role;

#VERSION:

use namespace::autoclean;

use Carp;

use Moose::Util::TypeConstraints;
enum 'SnmpVersion' => [qw(snmpv1 snmpv2c snmpv3)];
no Moose::Util::TypeConstraints;

requires
  '_build_driver',
  'get_scalar',
  'get_subtree';

has '_driver' => (
    is      => 'ro',
    isa     => 'Object',
    lazy    => 1,
    builder => '_build_driver',
);

has hostname => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has port => (
    is      => 'ro',
    isa     => 'Int',
    default => '161'
);

has localaddr => (
    is  => 'ro',
    isa => 'Str',
);

has localport => (
    is  => 'ro',
    isa => 'Int',
);

has version => (
    is       => 'ro',
    isa      => 'SnmpVersion',
    required => 1,
);

has 'timeout' => (
    is      => 'ro',
    isa     => 'Int',
    default => 5
);

has 'retries' => (
    is      => 'ro',
    isa     => 'Int',
    default => 5
);

has 'community' => (
    is  => 'ro',
    isa => 'Str',
);

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

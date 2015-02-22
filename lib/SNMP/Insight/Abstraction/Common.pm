package SNMP::Insight::Abstraction::Common;

#ABSTRACT: Common abstractions for all devices

use Moose::Role;

use namespace::autoclean;
use SNMP::Insight::MIB::Utils qw(sysObjectID2vendor);

#VERSION:

=attr os

Guessed device operating system. May be overridden by device roles.

=cut

has os => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_os',
);

sub _build_os { return '' }

=attr os_ver

Guessed device operating system version. May be overridden by device roles.

=cut

has os_version => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_os_version',
);

sub _build_os_version { return '' }

=attr vendor

Guessed device vendor. May be overridden by device roles.

=cut

has vendor => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_vendor'       
);

sub _build_vendor {
    my $self = shift;
    return sysObjectID2vendor( $self->sysObjectID ) || "";
}

=attr model

Guessed device model. May be overridden by device roles.

=cut

has model => (
    is  => 'ro',
    isa => 'Str',
    lazy => 1,
    builder => '_build_model',       
);

sub _build_model {  return ''; }

=attr interfaces

Mapping between the Interface Table Index (iid) and the physical port name.
Cisco/AggRole.pm

=cut

has interfaces => (
    is      => 'ro',
    isa     => 'HashRef',
    lazy    => 1,
    builder => '_build_interfaces',
);

sub _build_interfaces {
    my $self = shift;
    return $self->ifName;
}


1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight::Device;

#ABSTRACT: Base class for devices
use Moose;
use namespace::autoclean;

#VERSION:
use SNMP::Insight::Session;
use SNMP::Insight::MIB::Utils qw(sysObjectID2vendor);

=attr session

An L<SNMP::Insight::Session> instance used to retrieve SNMP info.

=cut

has 'session' => (
    isa => 'SNMP::Insight::Session',
    is  => 'ro',
);

=attr model

Guessed device model. May be overridden by device roles.

=cut

has model => (
    is  => 'ro',
    isa => 'Str'
);

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
    default => sub {
        my $self = shift;
        return sysObjectID2vendor( $self->sysObjectID ) || "";
    }
);

=attr interfaces

Mapping between the Interface Table Index (iid) and the physical port name.

=cut

has interfaces => (
    is      => 'ro',
    isa     => 'Hash',
    lazy    => 1,
    builder => '_build_interfaces',
);

sub _build_interfaces {
    my $self = shift;
    return $self->ifIndex;
}

=cut

=method get_all_mib_roles

Return all the MIB roles for this device.

=cut

sub get_all_mib_roles {
    my $self = shift;

    my @roles = grep { $_->can('mib_name') }
      $self->meta->calculate_all_roles_with_inheritance;

    return @roles;
}

with 'SNMP::Insight::MIB::SNMPv2', 'SNMP::Insight::MIB::IFMIB';

__PACKAGE__->meta->make_immutable;
1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

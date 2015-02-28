package SNMP::Insight::Device;

#ABSTRACT: Base class for devices
use Moose;
use namespace::autoclean;

#VERSION:
use SNMP::Insight::Session;

use Module::Runtime 0.014 'use_package_optimistically';
use Moose::Util 'is_role';

=attr session

An L<SNMP::Insight::Session> instance used to retrieve SNMP info.

=cut

has 'session' => (
    isa => 'SNMP::Insight::Session',
    is  => 'ro',
);

=method get_all_mib_roles

Return all the MIB roles for this device.

=cut

sub get_all_mib_roles {
    my $self = shift;

    my @roles = grep { $_->can('mib_name') }
      $self->meta->calculate_all_roles_with_inheritance;

    return @roles;
}

has device_type => (
    is => 'rw',
    isa => 'Str',
    trigger => \&_set_device_type
);

sub _set_device_type {
    my ( $self, $device_type, $old_value ) = @_;

    $old_value and confess "Device type can be set only once";
    
    my $role_package
        = _load_device_role( $device_type, 'SNMP::Insight::Device' );
    
    if ($role_package) {
        $role_package->meta->apply($self);
    }
    else {
        warn "role $device_type not found, using bare device";
    }
}

sub _load_device_role {
    my ( $role_name, $search_base ) = @_;

    my $possible_full_name = $search_base . "::" . $role_name;
    my @possible = ( $possible_full_name, $role_name );
    for my $name (@possible) {
        my $package = use_package_optimistically($name);
        use_package_optimistically($name);
        is_role($package) and return $package;
    }

    return;
}
    

with 'SNMP::Insight::MIB::SNMPv2',
  'SNMP::Insight::MIB::IFMIB',
  'SNMP::Insight::Abstraction::Common';

__PACKAGE__->meta->make_immutable;
1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

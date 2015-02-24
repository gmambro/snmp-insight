package SNMP::Insight::Device;

#ABSTRACT: Base class for devices
use Moose;
use namespace::autoclean;

#VERSION:
use SNMP::Insight::Session;

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

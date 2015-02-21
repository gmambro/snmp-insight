package SNMP::Insight::Abstraction;

# ABSTRACT: Device Abstraction helper role

use 5.010;
use Moose::Role;

# VERSION:

=head1 DESCRIPTION

Abstractions implement high level operation that are specific for a class of devices, e.g. retrieving the mac address table from a bridge or a list a installed software from a host.

  if ( $device->provides('Host') ) {
      @packages $device->installed_software;
  }

  if ( $device->provides('Bridge') ) {
      $interface = $device->mac_address_table->{$vlan}->{$mac_addr};
  }


Abstractions should hide all SNMP details.

=head1 WARNING

B<Abstrations are not implented yet>. Planned for 0.2

=cut

=method provides($name)

Return true if abstraction C<$name> is implemented by the device.

=cut

sub provides {
    my ($self, $name);

    return $self->does('SNMP::Insight::Abstraction', $name);
}

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

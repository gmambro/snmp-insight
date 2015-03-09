package SNMP::Insight::Device::Fortinet::Fortigate;

# ABSTRACT: Support for Fortinet's Fortigate devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

=head1 EXTENDS

=for :list

* L<SNMP::Insight::Device::Fortinet>

=cut

with 'SNMP::Insight::Device::Fortinet';

sub _build_model {
    my $self = shift;

    return $self->fnSysModel();
}

sub _build_os_version {
    my $self = shift;

    my $full_ver = $self->fgSysVersion();

    $full_ver =~ m/v(.+?),/io;

    return $1;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


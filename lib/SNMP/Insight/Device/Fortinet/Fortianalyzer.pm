package SNMP::Insight::Device::Fortinet::Fortianalyzer;

# ABSTRACT: Support for Fortinet's Fortianalyzer devices

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
    my $full_ver = $self->fa300SysVersion();

    $full_ver =~ m/(Fortianalyzer.+)\s/io ;

    return $1;
}

sub _build_os_version {
    my $self = shift;

    my $full_ver = $self->fa300SysVersion();

    $full_ver =~ m/v(.+?),/io ;

    return $1;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


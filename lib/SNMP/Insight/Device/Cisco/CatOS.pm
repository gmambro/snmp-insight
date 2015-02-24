package SNMP::Insight::Device::Cisco::CatOS;

# ABSTRACT: Support for Cisco Catalyst devices with CatOS

use Moose::Role;
use namespace::autoclean;

#VERSION:

=head1 EXTENDS

=for :list

* L<SNMP::Insight::Device::Cisco::L2Switch>

=cut

with
  'SNMP::Insight::Device::Cisco::L2Switch',

  #    'SNMP::Insight::MIB::Cisco_Stack',
  ;

sub _build_model {
    my $self = shift;
    my $id   = $self->sysObjectID;

    return $id;

    # return unless defined $id;

    # my $model = $self->translate($id);
    # return $id unless defined $model;

    # $model =~ s/^cisco//i;
    # $model =~ s/^catalyst//;
    # $model =~ s/^cat//;
    # return $model;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


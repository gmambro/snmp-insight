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

sub _build_os {
    return 'CatOS';
}

sub _build_os_ver {
    my $self  = shift;
    my $descr = $self->sysDescr();

    return unless defined $descr;
    
    $descr =~ m/V(\d{1}\.\d{2}\.\d{2})/ and return $1;
    
    $descr =~ m/Version (\d+\.\d+\([^)]+\)[^,\s]*)(,|\s)+/ and return $1;

    return;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


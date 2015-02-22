package SNMP::Insight::Device::Cisco::Catalyst;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

=head1 EXTENDS

=for :list

* L<SNMP::Insight::Device::Cisco::L2>

=cut

with
  'SNMP::Insight::Device::Cisco::L2',

  #    'SNMP::Insight::MIB::Cisco::Stack',
  ;


sub _build_model {
    my $self = shift;
    my $id   = $self->sysObjectID;

    unless ( defined $id ) {
        return;
    }

    my $model = $self->translate($id);

    return $id unless defined $model;

    $model =~ s/^cisco//i;
    $model =~ s/^catalyst//;
    $model =~ s/^cat//;
    return $model;
}


sub _build_os_ver {
    my $self  = shift;
    my $os    = $self->os();
    my $descr = $self->sysDescr();

    # Older Catalysts
    if (    defined $os
        and $os eq 'catalyst'
        and defined $descr
        and $descr =~ m/V(\d{1}\.\d{2}\.\d{2})/ )
    {
        return $1;
    }

    # Newer Catalysts and IOS devices
    if ( defined $descr
        and $descr =~ m/Version (\d+\.\d+\([^)]+\)[^,\s]*)(,|\s)+/ )
    {
        return $1;
    }
    return;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


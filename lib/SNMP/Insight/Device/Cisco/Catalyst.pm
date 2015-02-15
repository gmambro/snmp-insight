package SNMP::Insight::Device::Cisco::Catalyst;

# ABSTRACT: Support for Cisco Catalyst devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::Device::Cisco::L2Device',

  #    'SNMP::Insight::MIB::Cisco::Stack',
  ;

=method os

Ovveride method from SNMP::Insight::Device

=cut

sub os {
    my $self = shift;
    my $descr = $self->sysDescr || '';

    # order here matters - there are Catalysts that run IOS and have catalyst
    # in their description field.
    return 'ios'      if ( $descr =~ /IOS/ );
    return 'catalyst' if ( $descr =~ /catalyst/i );
    return;
}

=method model

Ovveride method from SNMP::Insight::Device

=cut

sub model {
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

=method os_ver

Ovveride method from SNMP::Insight::Device

=cut

sub os_ver {
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


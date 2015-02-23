package SNMP::Insight::Device::NetSNMP;

#ABSTRACT: Support for Net-SNMP agent

use 5.010;
use Moose::Role;
use namespace::autoclean;



#VERSION:

with
  'SNMP::Insight::MIB::UCD',
  'SNMP::Insight::MIB::HostResources';

sub _build_os {
    my $self = shift;
    my $descr = $self->sysDescr;

    my @fields = split /\s+/, $self->sysDescr;
    return $fields[0];   
}

sub _build_os_version {
    my $self = shift;

    my @fields = split /\s+/, $self->sysDescr;
    return $fields[2];   
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


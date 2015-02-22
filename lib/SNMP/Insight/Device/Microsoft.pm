package SNMP::Insight::Device::Microsoft;

#ABSTRACT: Support for Microsoft Windows agent

use Moose::Role;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB::HostResources';

sub _build_vendor {
    return 'Microsoft';
}

sub _build_os {
    my $self = shift;
    my $descr = $self->sysDescr;

    $descr =~ /Software: Windows/ and return "Windows";

    return;
}

sub _build_os_version {
    my $self = shift;
    
    my $descr = $self->sysDescr;
    $descr =~ /Windows Version\s+([\d\.]+)/ and return $1;

    return;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


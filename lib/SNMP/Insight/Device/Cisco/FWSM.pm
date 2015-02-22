package SNMP::Insight::Device::Cisco::FWSM;

# ABSTRACT: Support for Cisco FWSM devices

use Moose::Role;
use namespace::autoclean;

#VERSION:

with
  'SNMP::Insight::Device::Cisco',
  'SNMP::Insight::MIB::Bridge';

sub _build_os {
    my $self = shift;
    my $descr = $self->sysDescr || '';

    return 'fwsm' if ( $descr =~ /Cisco Secure FWSM Firewall/ );

    warn "Missing os recognition code";
}

warn "To be implemented yet";

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


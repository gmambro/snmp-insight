package SNMP::Easy::Device;

#ABSTRACT: Base class for devices
use Moose;
use namespace::autoclean;

#VERSION:
use SNMP::Easy::Session;
use SNMP::Easy::MIB::Utils qw(sysObjectID2vendor);

has 'session' => (
    isa => 'SNMP::Easy::Session',
    is  => 'ro',
);

sub model { return }

sub os { return }

sub os_ver { return }

has vendor => (
    is      => 'ro',
    isa     => 'Str',
    default => sub {
        my $self = shift;
        return sysObjectID2vendor( $self->sysObjectID ) || "";
    }
);

with 'SNMP::Easy::MIB::SNMPv2';

__PACKAGE__->meta->make_immutable;
1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

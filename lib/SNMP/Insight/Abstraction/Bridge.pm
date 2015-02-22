package SNMP::Insight::Abstraction::Bridge;

#ABSTRACT: support for Bridge Abstraction

use Moose::Role;

use namespace::autoclean;

#VERSION:

warn "This is a stub";

has mac_address_table => (
    is      => 'ro',
    isa     => 'Hash',
    lazy    => 1,
    builder => '_build_mac_address_table',
);

sub _build_mac_address_table {
    my $self = shift;

    my $interfaces = $self->interfaces;

    my $fw_mac    = $self->dot1dTpFdbAddress;
    my $fw_port   = $self->dot1dTpFdbPortt();
    my $fw_status = $self->dot1dTpFdbStatus();
    my $bp_index  = $self->dot1dBasePortIfIndex();

    my $mat = {};

    foreach my $fw_index ( keys %$fw_mac ) {
        my $status = $fw_status->{$fw_index};
        next if defined($status) and $status eq 'self';

        my $mac = $fw_mac->{$fw_index};

        # get bridge port id
        my $bp_id = $fw_port->{$fw_index};
        next unless defined $bp_id;

        # map bridge port id to interface id
        my $iid = $bp_index->{$bp_id};
        next unless defined $iid;

        # get port name from interface id
        my $port = $interfaces->{$iid};

        # update mat
        $mat->{default}->{$mac} = $port;
    }

    # TODO dot1q and cisco multi comunity (to be delegated)
    return $mat;
}

has aggregated_ports => (
    is      => 'ro',
    isa     => 'Hash',
    lazy    => 1,
    builder => '_build_aggregated_ports',
);

sub _build_aggregated_ports {
    my $self = shift;

    return {} unless $self->can('dot3adAggActorOperKey');

    my $masters = $self->dot3adAggActorOperKey;
    my $slaves  = $self->dot3adAggPortActorOperKey;

    return {} unless ref $masters eq 'HASH' and scalar keys %$masters;
    return {} unless ref $slaves eq 'HASH'  and scalar keys %$slaves;

    my $ret = {};
    foreach my $s ( keys %$slaves ) {
        next if $slaves->{$s} == 0;
        foreach my $m ( keys %$masters ) {
            next unless $masters->{$m} == $slaves->{$s};
            $ret->{$s} = $m;
            last;
        }
    }

    return $ret;
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight::Abstraction::Bridge;

#ABSTRACT: support for Bridge Abstraction

use Moose::Role;

use namespace::autoclean;

#VERSION:

warn "This is a stub";

warn "TODO get_mac_address_table";

sub aggregated_ports {
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

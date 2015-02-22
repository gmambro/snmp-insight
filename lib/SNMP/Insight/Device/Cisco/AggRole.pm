package SNMP::Insight::Device::Cisco::AggRole;

#ABSTRACT: support for Cisco Aggregation

use Moose::Role;

use namespace::autoclean;

#VERSION:

#requires 'aggregated_ports', 'pagpGroupIfIndex';

sub _agg_ports_pagp {
    my $self = shift;

    my $mapping = {};
    my $group   = $self->pagpGroupIfIndex;
    for my $slave ( keys %$group ) {
        my $master = $group->{$slave};
        next if ( $master == 0 || $slave == $master );
        $mapping->{$slave} = $master;
    }
    
    return $mapping;
}

# Combine PAgP data and LAG data
around 'aggregated_ports' => sub {
    my $orig = shift;
    my $self = shift;
    my $ret  = {
        %{ $self->_agg_ports_pagp },
        %{ $self->$orig }
    };
    return $ret;
};

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight::Utils;

# ABSTRACT: Support code for SNMP::Insight

use 5.010;
use strict;
use warnings FATAL => 'all';

# VERSION:

our ( @ISA, @EXPORT_OK );

BEGIN {
    require Exporter;
    @ISA       = qw(Exporter);
    @EXPORT_OK = qw( _debug _debug_level);
}

sub _debug {
    $ENV{SNMP_INSIGHT_DEBUG} and print STDERR "DEBUG: @_\n";
}

sub _debug_level {
    $ENV{SNMP_INSIGHT_DEBUG};
}

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok('SNMP::Easy') || print "Bail out!\n";
}

diag("Testing SNMP::Easy $SNMP::Easy::VERSION, Perl $], $^X");

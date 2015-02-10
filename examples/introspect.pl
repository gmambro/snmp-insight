#!/usr/bin/env perl
use strict;
use warnings;

use SNMP::Easy::Session::NetSNMP;
use SNMP::Easy;

use Data::Dumper;

use Getopt::Long;

my $hostname  = 'localhost';
my $community = 'public';

GetOptions(
    'host=s'      => \$hostname,
    'community=s' => \$community
) or die("Error in command line arguments");

my $session = SNMP::Easy::Session::NetSNMP->new(
    hostname  => $hostname,
    community => $community,
    version   => "snmpv2c",
);

my $device = SNMP::Easy::open( session => $session );

my @roles = $device->meta->calculate_all_roles;
foreach my $role (@roles) {
    $role->can('mib_name') or next;

    print "MIB ", $role->mib_name, "\n";

    foreach my $attr ( $role->get_attribute_list ) {
        print " $attr ", Dumper( $device->$attr ), "\n";
    }

}

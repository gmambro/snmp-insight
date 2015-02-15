#!/usr/bin/env perl
use strict;
use warnings;

use SNMP::Insight::Session::NetSNMP;
use SNMP::Insight;

use Getopt::Long;
use Data::Dumper;

my $hostname  = 'localhost';
my $community = 'public';

GetOptions(
    'host=s'      => \$hostname,
    'community=s' => \$community
) or die("Error in command line arguments");

my $session = SNMP::Insight::Session::NetSNMP->new(
    hostname  => $hostname,
    community => $community,
    version   => "2c",
);

my $device = SNMP::Insight::open( session => $session );

print "Description ", $device->sysDescr,    "\n";
print "Object ID ",   $device->sysObjectID, "\n";
print "Services ",    $device->sysServices, "\n";
print "Vendor ",      $device->vendor,      "\n";

print Dumper( $device->ifTable );
print Dumper( $device->ifXTable );

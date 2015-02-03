
#!/usr/bin/env perl
use strict;
use warnings;

use SNMP::Easy::Session::NetSNMP;
use SNMP::Easy;

use Getopt::Long;

my $hostname = 'localhost';
my $community = 'community';

GetOptions(
    'host=s'       => \$hostname,
    'community=s'  => \$community) or die ("Error in command line arguments");

my $session = SNMP::Easy::Session::NetSNMP->new(
    hostname  => $hostname,
    community => $community,
    version   => "snmpv2c",
);

my $device = SNMP::Easy::open( session => $session );

print "Description ", $device->sysDescr,    "\n";
print "Object ID ", $device->sysObjectID, "\n";
print "Services ", $device->sysServices, "\n";
print "Vendor ",  $device->vendor,       "\n";
print "Version ", $device->versionIndex, "\n";

use Data::Dumper;

print Dumper ( $device->ifTable );
print Dumper ( $device->ifXTable );

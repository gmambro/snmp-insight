#!/usr/bin/env perl
use strict;
use warnings;

use SNMP::Insight::Session::NetSNMP;
use SNMP::Insight;

use Data::Dumper;

use Getopt::Long;

my $hostname  = 'localhost';
my $community = 'public';
my $verbose;

GetOptions(
    'host=s'      => \$hostname,
    'community=s' => \$community,
    'verbose'     => \$verbose,
) or die("Error in command line arguments");

my $device = SNMP::Insight::open(
    snmp_params => {
        hostname  => $hostname,
        community => $community,
        version   => "2c"
    }
);

print "Device Type: ", $device->device_type, "\n";
print "Vendor: ",      $device->vendor,      "\n";
print "OS: ",          $device->os,          "\n";
print "OS Version: ",  $device->os_version,  "\n";

my @roles = $device->get_all_mib_roles;
foreach my $role (@roles) {
    print "MIB ", $role->mib_name, "\n";

    if ($verbose) {
        foreach my $attr_name ( $role->get_attribute_list ) {
            my $attr = $device->meta->find_attribute_by_name($attr_name);

            $attr->does('SNMP::Insight::Meta::Attribute::Trait::MIBEntry')
              or next;

            $attr->is_scalar
              and print " $attr_name: ", $device->$attr_name, "\n";

            $attr->is_table
              and print " $attr_name: ", Dumper( $device->$attr_name );
        }

    }
}

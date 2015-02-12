package SNMP::Easy;

# ABSTRACT: SNMP Moose interface

use 5.010;
use strict;
use warnings FATAL => 'all';

# VERSION:

use Module::Runtime 0.014 'use_package_optimistically';
use Moose::Util 'is_role';
use SNMP::Easy::Device;

=func open()

Create a SNMP::Easy::Device object, loading all the needed MIBS.

=cut

sub open {
    my %args = @_;

    my $session = $args{session};
    if ( !defined($session) ) {
        my $session_class =
          $args{session_class} || 'SNMP::Easy::Session::NetSNMP';
        $session = _load_class( $session_class,
            'SNMP::Easy::Session', @{ $args{snmp_params} } );
    }

    my $device = SNMP::Easy::Device->new( session => $session );

    my $classifier_class = $args{classifier} || 'SNMP::Easy::Classifier';
    my $classifier = _load_class( $classifier_class, 'SNMP::Easy::Classifier',
        device => $device );

    my $device_role = $classifier->classify();

    if (!$device_role) {
        debug() and print "debug: no info from classifier";
        return $device;
    }
                
    debug() and print "debug: classifier returned $device_role";
    my $role_package =
        _load_device_role( $device_role, 'SNMP::Easy::Device' );
    if ($role_package) {
        $role_package->meta->apply($device);
    }
    else {
        warn "$role_package not found, using bare device";
    }

    return $device;
}

sub _load_class {
    my ( $class_name, $search_base, %options ) = @_;

    my $possible_full_name = $search_base . "::" . $class_name;
    my @possible = ( $possible_full_name, $class_name );
    for my $name (@possible) {
        my $package = use_package_optimistically($name);
        $package->can('new') and return $package->new(%options);
    }

    return;
}

sub _load_device_role {
    my ( $role_name, $search_base ) = @_;

    my $possible_full_name = $search_base . "::" . $role_name;
    my @possible = ( $possible_full_name, $role_name );
    for my $name (@possible) {
        my $package = use_package_optimistically($name);
        use_package_optimistically($name);
        is_role($package) and return $package;
    }

    return;
}

=func debug

Internal

=cut

sub debug {
    return $ENV{SNMP_EASY_DEBUG};
}

=head1 SYNOPSIS

SNMP Moose interface:

    use SNMP::Easy;

    my $device = SNMP::Easy::open( 
        snmp_params => { 
            hostname  => 'localhost',
            community => 'public',
            version   => "snmpv2c",
        });

    ...

=head1 DESCRIPTION

SNMP::Easy is a Perl 5 module that provides a simple Object Oriented inteface to access SNMP enabled devices and to describe SNMP MIBs and devices. SNMP::Easy it's based on Moose and uses Net::SNMP for a pure Perl SNMP implementation.

Warning: this release is still alpha quality!

=head1 SEE ALSO

=for :list

* In the SNMP::Easy distribution 
L<SNMP::Easy::Session>
L<SNMP::Easy::Device> 
L<SNMP::Easy::Classifier>
L<SNMP::Easy::MIB>

* Similar modules on CPAN <SNMP::Info> 

=cut

1;    # End of SNMP::Easy

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

package SNMP::Insight;

# ABSTRACT: SNMP Moose interface

use 5.010;
use strict;
use warnings FATAL => 'all';

# VERSION:

use Module::Runtime 0.014 'use_package_optimistically';

use Scalar::Util qw(blessed);

use SNMP::Insight::Device;
use SNMP::Insight::Utils qw(_debug);

=func open()

Create a SNMP::Insight::Device object, loading all the needed MIB roles.

=cut

sub open {
    my %args = @_;

    my $session = $args{session};
    if ( !defined($session) ) {
        my $session_class
          = $args{session_class} || 'SNMP::Insight::Session::NetSNMP';
        $session = _load_class(
            $session_class,
            'SNMP::Insight::Session', %{ $args{snmp_params} }
        );
    }

    my $device = SNMP::Insight::Device->new( session => $session );


    # if classifier exists but is undef it means we should not use any
    # classifier

    if ( $args{classifier} || !exists $args{classifier} ) {
        my $device_type;
        
        my $classifier = $args{classifier};

        if ( !$classifier || !blessed($classifier) ) {
            my $classifier_class = $classifier || 'SNMP::Insight::Classifier';
            $classifier = _load_class(
                $classifier_class, 'SNMP::Insight::Classifier',
                device => $device
            );
        }

        $device_type = $classifier->classify();

        if ( !$device_type ) {
            _debug("No info from Classifier");
            return $device;
        }

        _debug("Classifier returned: $device_type");
        $device_type and $device->device_type($device_type);
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


=head1 SYNOPSIS

SNMP Moose interface:

    use SNMP::Insight;

    my $device = SNMP::Insight::open( 
        snmp_params => { 
            hostname  => 'localhost',
            community => 'public',
            version   => "2c",
        });

    ...

=head1 DESCRIPTION

SNMP::Insight is a Perl 5 module that provides a simple Object
Oriented inteface to access SNMP enabled devices and to describe SNMP
MIBs and devices. SNMP::Insight it's based on Moose and uses Net::SNMP
for a pure Perl SNMP implementation.

Warning: this release is still alpha quality!

=head1 SEE ALSO

=for :list

* In the SNMP::Insight distribution 
L<SNMP::Insight::Session>
L<SNMP::Insight::Device> 
L<SNMP::Insight::Classifier>
L<SNMP::Insight::MIB>

* Modules on CPAN L<SNMP::Info> 

=head1 ACKNOWLEDGEMENTS

Heavily inspired by L<SNMP::Info>, many pieces of code in
SNMP::Insight are based on the great work of its authors.

Patch and support provided by

=for :list

* Vittorio Nesta

* Enrico Liguori

=cut

1;    # End of SNMP::Insight

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

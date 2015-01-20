package SNMP::Easy;
# ABSTRACT: SNMP Moose interface
use 5.010;
use strict;
use warnings FATAL => 'all';

use Module::Runtime 0.014 'use_package_optimistically';
use Moose::Util 'is_role';
use SNMP::Easy::Device;

our $VERSION = '0.01';


sub open {
    my %args = @_;
    
    my $session = $args{session};
    if (!defined($session)) {
	my $session_class = $args{session_class} || 'SNMP::Easy::Session::NetSNMP';
	$session = _load_class(
	    $session_class,
	    'SNMP::Easy::Session',
	    @{$args{session_args}});
    }

    my $device = SNMP::Easy::Device->new(session => $session);
    
    my $classifier_class = $args{classifier} || 'SNMP::Easy::Classifier';
    my $classifier = _load_class($classifier_class,
				 'SNMP::Easy::Classifier',
				 device => $device);

    my $device_role = $classifier->classify();
        
    $ENV{SNMP_EASY_DEBUG} and print "debug: classifier $device_role";
    
    my $role_package = use_package_optimistically($device_role);
    is_role($role_package) or die "$role_package is not a Moose role";
    
    $role_package->meta->apply( $device );
        
    return $device;
}

sub _load_class {
    my ($class_name, $search_base,  %options) = @_ ;
    
    my $possible_full_name = $search_base . "::" . $class_name;
    my @possible = ($possible_full_name, $class_name);
    for my $name  (@possible) {
	my $package = use_package_optimistically($name);
	$package->can('new') and return $package->new(%options);
    }

    die "Cannot load classifier $class_name";
}


=head1 SYNOPSIS

SNMP Moose interface:

    use SNMP::Easy;

    my $foo = SNMP::Easy->new();
    ...

=head1 DESCRIPTION

A Perl 5 module that provides a simple Moose object-oriented access to SNMP enabled devices and SNMP MIBs.

SNMP::Easy uses Net::SNMP for a pure Perl SNMP implementation.
It's based on Moose to provide simple mechanisms to add support for
more MIBs and agents.

=head1 AUTHOR

Gabriele Mambrini, C<< <g.mambrini at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-snmp-easy at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SNMP-Easy>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SNMP::Easy


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SNMP-Easy>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SNMP-Easy>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SNMP-Easy>

=item * Search CPAN

L<http://search.cpan.org/dist/SNMP-Easy/>

=back
=cut

1; # End of SNMP::Easy
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

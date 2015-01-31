use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'SNMP::Easy',
    AUTHOR             => q{Gabriele Mambrini <g.mambrini@gmail.com>},
    VERSION_FROM       => 'lib/SNMP/Easy.pm',
    ABSTRACT_FROM      => 'lib/SNMP/Easy.pm',
    LICENSE            => 'Artistic_2_0',
    PL_FILES           => {},
    MIN_PERL_VERSION   => 5.010,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Moose'                => '2.14',
        'Net::SNMP'            => 'v6.0.1',
        'namespace::autoclean' => '0.24',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'SNMP-Easy-*' },
);

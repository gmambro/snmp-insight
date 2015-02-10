package SNMP::Easy::MIB::UCD;

#ABSTRACT: Support for data in UCD MIB

use Moose::Role;

use SNMP::Easy::Moose::MIB;
use namespace::autoclean;

#VERSION:

with 'SNMP::Easy::MIB';

# See http://www.net-snmp.org/docs/mibs/UCD-SNMP-MIB.txt

# { enterprises 2021 }
mib_oid ".1.3.6.1.4.1.2021";
mib_name "UCD-SNMP-MIB";

has_scalar memTotalSwap => ( oid => '4.3' );
has_scalar memAvailSwap => ( oid => '4.4' );
has_scalar memTotalReal => ( oid => '4.5' );
has_scalar memAvailReal => ( oid => '4.6' );


has_table prTable => (
   oid     => '2.1',
   index   => 'prIndex',
   columns => {
       prIndex   => 1,
       prNames   => 2,
       prMin     => 3,
       prMax     => 4,
       prCount   => 5,
   }
);

has_table dskTable => (
    oid    => '9.1',
    index  => 'dskIndex',
    columns => {
        dskIndex	=> 1,
        dskPath		=> 2,
        dskDevice	=> 3,
        dskMinimum	=> 4,
        dskMinPercent	=> 5,
        dskTotal	=> 6,
        dskAvail	=> 7,
        dskUsed		=> 8,
        dskPercent      => 9,
        dskPercentNode	=> 10
    },
);



1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


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

#TODO

# --   prTable          OBJECT IDENTIFIER ::= { ucdavis   2 }
#has_table "prTable" => (
#   oid     => '.2',
#    columns => {}
#);

# --   memory           OBJECT IDENTIFIER ::= { ucdavis   4 }
# --   extTable         OBJECT IDENTIFIER ::= { ucdavis   8 }
# --   diskTable        OBJECT IDENTIFIER ::= { ucdavis   9 }
# --   loadTable        OBJECT IDENTIFIER ::= { ucdavis  10 }
# --   systemStats      OBJECT IDENTIFIER ::= { ucdavis  11 }
# --   fileTable        OBJECT IDENTIFIER ::= { ucdavis  15 }
# --   logMatch         OBJECT IDENTIFIER ::= { ucdavis  16 }

# --   version          OBJECT IDENTIFIER ::= { ucdavis 100 }
has_scalar "versionIndex" => ( oid => '.100.1', );

# --   snmperrs         OBJECT IDENTIFIER ::= { ucdavis 101 }

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


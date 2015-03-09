package SNMP::Insight::MIB::Fortinet;

#ABSTRACT: Support for data in FORTINET-CORE-MIB, FORTINET-FORTIGATE-MIB, FORTINET-FORTIANALYZER-MIB

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.12356";
mib_name "FORTINET-MIB";

# FORTINET-CORE-MIB
has_scalar fnSysSerial => ( oid => '100.1.1.1' );

# FORTINET-FORTIGATE-MIB
has_scalar fnSysModel => ( oid => '1.1' );
has_scalar fgSysVersion => ( oid => '101.4.1.1' );

# FORTINET-FORTIANALYZER-MIB
has_scalar fa300SysVersion => ( oid => '102.99.2.2' );

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

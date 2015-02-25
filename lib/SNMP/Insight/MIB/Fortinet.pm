package SNMP::Insight::MIB::Fortinet;

#ABSTRACT: Support for data in FORTINET-MIB-280

use Moose::Role;

#VERSION:

use SNMP::Insight::Moose::MIB;

use namespace::autoclean;
with 'SNMP::Insight::MIB';

mib_oid "1.3.6.1.4.1.12356";
mib_name "FORTINET-MIB-280";


has_scalar fnSysModel => (
    oid => '1.1'
);

has_scalar fnSysSerial => (
    oid => '1.2'
);

has_scalar fnSysVersion => (
    oid => '1.3'
);

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

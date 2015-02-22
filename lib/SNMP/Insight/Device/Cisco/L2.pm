package SNMP::Insight::Device::Cisco::L2;

# ABSTRACT: Support for Generic Cisco L2 device

use Moose::Role;
use namespace::autoclean;

#VERSION:

=head1 EXTENDS

=for :list

* L<SNMP::Insight::MIB::Bridge>

* L<SNMP::Insight::MIB::Cisco_VTP>

* L<SNMP::Insight::MIB::Cisco_CDP>

=cut

with
  'SNMP::Insight::Device::Cisco',

  'SNMP::Insight::MIB::Bridge',
  'SNMP::Insight::MIB::Cisco_VTP',
  'SNMP::Insight::MIB::Cisco_PAGP',
  'SNMP::Insight::MIB::Cisco_StpExtensions',
  'SNMP::Insight::MIB::IEEE8023_LAG',
  'SNMP::Insight::MIB::Cisco_RTTMON',
  'SNMP::Insight::Abstraction::Bridge',
  'SNMP::Insight::Device::Cisco::AggRole';

# 'SNMP::Insight::MIB::Cisco_Stats',
# 'SNMP::Insight::MIB::Cisco_Config',
# 'SNMP::Insight::MIB::Cisco_PortSecurity',

1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:

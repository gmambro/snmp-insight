package SNMP::Insight::MIB::IEEE8023_LAG;

#ABSTRACT: Support for data in LAG MIB

use Moose::Role;

use SNMP::Insight::Moose::MIB;
use namespace::autoclean;

#VERSION:

with 'SNMP::Insight::MIB';

mib_name 'IEEE8023-LAG-MIB';
mib_oid '1.2.840.10006.300.43';


=attr dot3adAggTable

A table that contains information about every Aggregator that is
associated with this System

=attr dot3adAggActorOperKey

The current operational value of the Key for the Aggregator. The
administrative Key value may differ from the operational Key value for
the reasons discussed in 43.6.2. This is a 16-bit read-only value. The
meaning of particular Key values is of local significance.


=cut

has_table 'dot3adAggTable' => (
    oid => '1.1',
    columns => {
	dot3adAggActorOperKey => 7,
    }
);

=attr dot3adAggPortTable

A table that contains Link Aggregation Control configuration
information about every Aggregation Port associated with this device.
A row appears in this table for each physical port.

=attr dot3adAggPortSelectedAggID 

The identifier value of the Aggregator that this Aggregation Port has
currently selected. Zero indicates that the Aggregation Port has not
selected an Aggregator, either because it is in the process of
detaching from an Aggregator or because there is no suitable
Aggregator available for it to select.  This value is read-only."

=attr dot3adAggPortActorOperKey

The current operational value of the Key for the Aggregation
Port. This is a 16-bit read-only value.  The meaning of particular Key
values is of local significance.

=cut

has_table ' dot3adAggPortTable' => (
    oid => '1.2.1',
#    index => 'dot3adAggPortIndex',
    columns => {
	dot3adAggPortIndex => 1,
	# in
	dot3adAggPortSelectedAggID => 12,
	dot3adAggPortActorOperKey  => 5,
    };
    
);


1;

# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 4
# cperl-indent-parens-as-block: t
# End:


package Net::AnywhereUSB::System::Network;

use strict;
use warnings;

our @ATTR = qw(
	active_opens
	attempt_fails
	bad_datagrams_received
	bad_messages_received
	bad_segments_received
	bytes_received
	bytes_sent
	currently_established
	datagrams_forwarded
	datagrams_received
	datagrams_sent
	default_time-to-live
	dest_unreachable_messages_received
	dest_unreachable_messages_sent
	established_resets
	forwarding
	messages_received
	messages_sent
	non-unicast_packets_received
	non-unicast_packets_sent
	no_ports
	no_routes
	passive_opens
	resets_sent
	routing_discards
	segments_received
	segments_retransmitted
	segments_sent
	unicast_packets_received
	unicast_packets_sent
	unknown_protocol_packets_received
);

{ 
no strict 'refs';

	for my $attr ( @ATTR ) {
		*{ __PACKAGE__ . "::$attr" } = sub {
			my $self = shift;
			return $self->{ $attr }
		}
	}
}

sub new {
	my ( $class, %args ) = @_;

	my $self = bless {}, $class;
	$self->__init( %args );

	return $self
}

sub __init {
	my ( $self, %args ) = @_;

	for my $k ( keys %args ) {
		$self->{ $k } = $args{ $k } 
	}
}

1;

__END__

=pod

=head1 NAME

Net::AnywhereUSB::System::Network - Utility class for representing network
metrics of a Digi AnywhereUSB device.

=head1 SYNOPSIS

This module provides a utility class for representing observed network metrics 
as returned by a Digi AnywhereUSB device.

Note that you should not instantiate objects of this class directly - rather
objects of this class will returned when invoking the network_information() 
method in the L<Net::AnywhereUSB> module.

=head1 METHODS

=head2 active_opens ( )

Returns the number of active connection openings.

=head2 attempt_fails ( )

Returns the number of attempted connection failures.

=head2 bad_datagrams_received ( )

Returns the number of bad datagrams received.

=head2 bad_messages_received ( )

Returns the number of bad messages received.

=head2 bad_segments_received ( )

Returns the number of bad segments received.

=head2 bytes_received ( )

Returns the number of bytes received.

=head2 bytes_sent ( )

Returns the number of bytes sent.

=head2 currently_established ( )

Returns the number of currently established connections.

=head2 datagrams_forwarded ( )

Returns the number of datagrams forwarded.

=head2 datagrams_received ( )

Returns the number of datagrams received.

=head2 datagrams_sent ( )

Returns the number of datagrams sent.

=head2 default_time-to-live ( )

Returns the default TTL.

=head2 dest_unreachable_messages_received ( )

Returns the number of destination unreachable messages received.

=head2 dest_unreachable_messages_sent ( )

Returns the number of destination unreachable messages sent.

=head2 established_resets ( )

Returns the number of established connection resets.

=head2 forwarding ( )

Returns the forwarding state (1 - enabled, 0 - disabled).

=head2 messages_received ( )

Returns the number of messages received.

=head2 messages_sent ( )

Returns the number of messages sent.

=head2 non-unicast_packets_received ( )

Returns the number of non-unicast packets received.

=head2 non-unicast_packets_sent ( )

Returns the number of non-unicast messages sent.

=head2 no_ports ( )

Returns the number of datagrams sent for which there was no application at the
destination port.

=head2 no_routes ( )

Returns the number of datagrams that were discarded due to no destination 
route.

=head2 passive_opens ( )

Returns the number of passive opens.

=head2 resets_sent ( )

Returns the number of requests sent.

=head2 routing_discards ( )

Returns the number of routing discards.

=head2 segments_received ( )

Returns the number of segments received.

=head2 segments_retransmitted ( )

Returns the number of segments retransmitted.

=head2 segments_sent ( )

Returns the number of segments sent.

=head2 unicast_packets_received ( )

Returns the number of unicast packets received.

=head2 unicast_packets_sent ( )

Returns the number of unicast packets sent.

=head2 unknown_protocol_packets_received ( )

returns the number of packets received with an unknown protocol.

=cut

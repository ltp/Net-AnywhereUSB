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

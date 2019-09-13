package Net::AnywhereUSB::System::Summary;

use strict;
use warnings;

our @ATTR = qw(
	contact
	description
	device_id
	ethernet_ip_address
	ethernet_mac_address
	location
	model
);

{
no strict 'refs';

	for my $attr ( @ATTR ) {
		*{ __PACKAGE__ ."::$attr" } = sub {
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

	for my $attr ( @ATTR ) {
		$self->{ $attr } = $args{ $attr }
	}
}

1;

__END__

=pod

=name1 NAME

Net::AnywhereUSB::System::Summary - Utility class for representing system
summary data returned from Digi AnywhereUSB devices.

=head1 SYNOPSIS

This module is a utility class for representing information system summary
information returned from Digi AnywhereUSB devices.

Note that you should not instantiate objects of this class directly - rather
objects of this class will returned when invoking the summary() method in the 
L<Net::AnywhereUSB> module.

=head1 METHODS

=head2 contact ( )

Returns the device contact.

=head2 description ( )

Returns the device description.

=head2 device_id ( )

returns the device ID.

=head2 ethernet_ip_address ( )

Returns the device IP address.

=head2 ethernet_mac_address ( )

Returns the device MAC address.

=head2 location ( )

Returns the device location.

=head2 model ( )

Returns the device model string.

=cut

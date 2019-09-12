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

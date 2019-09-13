package Net::AnywhereUSB::Common::Value;

use strict;
use warnings;

use overload '""' => '__as_string';

sub new {
	my ( $class, $arg  ) = @_;

	my $self = bless {} , $class;
	$self->__init( $arg );

	return $self
}

sub __init {
	my ( $self, $arg ) = @_;

	my ( $value, $units ) = ( split / /, $arg );
	$self->{ value } = $value;
	$self->{ units } = $units;
}

sub value {
	return $_[0]->{ value }
}

sub units {
	return $_[0]->{ units }
}

sub as_bits {
	my $self = shift;

	if ( ( lc $self->{ units } ) eq 'b' ) {
		return $self->{ value }
	}
	elsif ( ( lc $self->{ units } ) eq 'kb' ) {
		return ( $self->{ value } * 1024 )
	}
	elsif ( ( lc $self->{ units } ) eq 'mb' ) {
		return ( $self->{ value } * 1024 * 1024 )
	}
	elsif ( ( lc $self->{ units } ) eq 'gb' ) {
		return ( $self->{ value } * 1024 * 1024 * 1024 )
	}
	else {
		return $self->{ value }
	}
}

sub __as_string {
	my $self = shift;

	return $self->{ value }." ".$self->{ units }
}

1;

__END__

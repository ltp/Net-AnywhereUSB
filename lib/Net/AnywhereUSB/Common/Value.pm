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

=pod

=head1 NAME

Net::AnywhereUSB::Common::Value - A utility class for reported values.

=head1 SYNOPSIS

This module provides a utility class for values reported by Digi AnywhereUSB
devices.  Note that you should not instantiate objects of this class yourself,
rather, objects of this class will be returned when invoking methods in the
L<Net::AnywhereUSB> module.

Values returns by methods in L<Net::AnywhereUSB> which return system information
are in some instances composed of a value and a unit.  For example; values 
regarding memory capacity and utilisation may be returned as an integer 
representing the measured value and string representing the unit of 
measurement.  i.e. 20128 KB.

The methods in this module provide conveniences for returning the value portion
of the reported metric, the unit portion, and the value expressed in bits.

Objects of this class implement overload stringification and so can be used _as_
_expected_ in output.

=head1 METHODS

=head2 value ( )

Returns the value portion of the observed metric.

=head2 units ( )

Returns the units portion of the observed metric;

=head2 as_bits ( )

Returns the observed value expressed in bits.

=cut

package Net::AnywhereUSB::Common::Value;

use strict;
use warnings;

use overload '""' => '__as_string';

sub new {
	my ( $class, $value  ) = @_;

	( $value, $units ) = ( split / /, $value );
	my $self = bless {} , $class;
	$self->{ value } = $args{ value };
	$self->{ units } = $args{ units };

	return $self
}

sub to_bits {
	
}

sub __as_string {
	my $self = shift;

	return $self->{ value }
}

1;

__END__

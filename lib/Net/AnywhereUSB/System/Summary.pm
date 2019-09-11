package Net::AnywhereUSB::System::Summary;

use strict;
use warnings;

sub new {
	my ( $class, %args ) = @_;

	my $self = bless {}, $class;
	$self->__init( %args );

	return $self
}

sub __init {
	my ( $self, %args ) = @_;

	use Data::Dumper;
	print Dumper( %args );
}

1;

__END__

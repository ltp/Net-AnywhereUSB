package Net::AnywhereUSB::System::Information;

use strict;
use warnings;

use Net::AnywhereUSB::Common::Value;

our @ATTR = qw(
	boot_version 
	cpu_utilization 
	ethernet_mac_address 
	firmware_version 
	free_flash_filesystem 
	free_memory 
	hardware_strapping 
	model 
	post_version 
	product_id 
	product_vpd_version 
	total_flash_filesystem	
	total_memory		
	up_time			
	used_flash_filesystem	
	used_memory
);

{ 
no strict 'refs';

	for my $attr ( @ATTR ) {
		*{ __PACKAGE__ . "::$attr" } = sub {
			my $self = shift;
			return ( $attr =~ /(flash|memory)/
				? Net::AnywhereUSB::Common::Value->new( $self->{ $attr } )
				: $self->{ $attr } );
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



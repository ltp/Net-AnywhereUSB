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

=pod

=head1 NAME

Net::AnywhereUSB::System::Information - Utility class for representing system
information returned from a Digi AnywhereUSB device.

=head1 SYNOPSIS

This module provide a utility class for representing system informmation 
returned from a Digi AnywhereUSB device.

Note that you should not instantiate objects of this class directly - rather
objects of this class will returned when invoking the system_information() 
method in the L<Net::AnywhereUSB> module.

=head1 METHODS

=head2 boot_version ( )

Returns the boot version string.

=head2 cpu_utilization  ( )

Returns the CPU utilisation expressed as a percentage.

=head2 ethernet_mac_address  ( )

Returns the MAC address of the device.

=head2 firmware_version  ( )

Returns the firmware version string.

=head2 free_flash_filesystem  ( )

Returns the amount of free space available in the flash filesystems as a
L<Net::AnywhereUSB::Common::Value> object.

=head2 free_memory  ( )

Returns the amount of free memory available as a 
L<Net::AnywhereUSB::Common::Value> object.

=head2 hardware_strapping  ( )

Returns the hexadecimal value of the hardware strapping pin.

=head2 model  ( )

Returns the model information string.

=head2 post_version  ( )

Returns the POST version string.

=head2 product_id  ( )

Returns the product ID string.

=head2 product_vpd_version  ( )

Returns the product VPD version string.

=head2 total_flash_filesystem	 ( )

Returns the total amount of installed flash file system capacity as a
L<Net::AnywhereUSB::Common::Value> object.

=head2 total_memory		 ( )

Returns the total amount of memory installed as a 
L<Net::AnywhereUSB::Common::Value> object.

=head2 up_time			 ( )

Returns the system uptime.

=head2 used_flash_filesystem	 ( )

Returns the used amount of the flash file system as a
L<Net::AnywhereUSB::Common::Value> object.

=head2 used_memory ( )

Returns the amount of memory used as a L<Net::AnywhereUSB::Common::Value> 
object.

=head2 

=cut

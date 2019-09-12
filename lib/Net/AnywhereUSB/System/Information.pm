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

#	for my $attr ( grep /(flash|memory)/, @ATTR ) {
#		*{ __PACKAGE__. "::$attr" } = sub {
#			my $self = shift;
#			return Net::AnywhereUSB::Common::Value->new( $self->{ $attr } )
#		}
#	}
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


'used_flash_filesystem' => '21 KB',
'post_version' => '1.09.9.39 (release 82001552_A generic_travis hwdiag 11/09/2009)',
'hardware_strapping' => '0x0000',
'total_flash_filesystem' => '553 KB',
'total_memory' => '131072 KB',
'cpu_utilization' => '1%',
'used_memory' => '11463 KB',
'product_id' => '0x0121',
'model' => 'AnywhereUSB/14',
'ethernet_mac_address' => '00:40:9D:44:F3:96',
'product_vpd_version' => 'none',
'up_time' => '2 days 3 hours 32 minutes 27 seconds',
'boot_version' => '1.09.10.6 (release 82002082_B awusb14 bootloader 11/09/2009)',
'firmware_version' => '1.97.22.4 (build 82002081_R1 awusb14 eos 1/22/2019 11:31:26a)',
'free_memory' => '119609 KB',
'free_flash_filesystem' => '532 KB'


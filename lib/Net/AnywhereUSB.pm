package Net::AnywhereUSB;

use strict;
use warnings;

use LWP;
use HTML::TreeBuilder;
use IO::Socket::SSL;
use Net::AnywhereUSB::System::Information;
use Net::AnywhereUSB::System::Network;
use Net::AnywhereUSB::System::Summary;

our $VERSION = '0.1';

our %DEFAULTS = (
	timout		=> 10,
	proto		=> 'https',
	ssl_verify	=> 0
);

sub new {
	my ( $class, %args ) = @_;

	my $self = bless {}, $class;
	$self->__init( %args );

	return $self
}

sub __init {
	my ( $self, %args ) = @_;

	for my $i ( qw(username server password) ) {
		defined $args{ $i } 
			or die "Mandatory parameter '$i' not provided in constructor.\n";
		$self->{ opts }->{ $i } = $args{ $i }
	}

	for my $i ( keys %DEFAULTS ) {
		$self->{ opts }->{ $i } = defined $args{ $i }
			? $args{ $i }
			: $DEFAULTS{ $i };
	}

	$self->{ opts }->{ ssl_verify }
		or $self->{ opts }->{ ssl_opts } = { 
				verify_hostname => 0, 
				SSL_verify_mode => IO::Socket::SSL::SSL_VERIFY_NONE 
		};

	$self->{ __ua } = LWP::UserAgent->new( 
				timeout		=> $self->{ opts }->{ timeout },
				cookie_jar	=> {},
				ssl_opts	=> $self->{ opts }->{ ssl_opts }
			);

	$self->{ __tb } = HTML::TreeBuilder->new();
}

sub summary {
	return $_[0]->__system_summary()
}

sub __system_summary {
	my $self = shift;

	my $s = $self->__tb->parse_content( $self->__get( __home_uri() ) );

	my @h = $s->look_down( _tag => 'td', class => 'field-label' );
	map {
		$_ = $_->as_trimmed_text( extra_chars => '\xA0' );
		$_ =~ s/://;
		$_ =~ tr/A-Z /a-z_/;
		$_
	} @h;
		
	my @v = $s->look_down( _tag => 'td', class => 'field-value' );
	map {
		$_ = $_->as_trimmed_text( extra_chars => '\xA0' ); 
		$_
	} @v;

	my %d;
	@d{ @h } = @v;

	return Net::AnywhereUSB::System::Summary->new( %d )
	
}

sub system_information {
	return $_[0]->__system_information()
}

sub __system_information {
	my $self = shift;

	my $s = $self->__tb->parse_content( $self->__get( __system_information_uri() ) );

	my @h = $s->look_down( _tag => 'td', class => 'field-label' );
	map {
		$_ = $_->as_trimmed_text( extra_chars => '\xA0' );
		$_ =~ s/://;
		$_ =~ tr/A-Z /a-z_/;
		$_
	} @h;
		
	my @v = $s->look_down( _tag => 'td', class => 'field-value' );
	map {
		$_ = $_->as_trimmed_text( extra_chars => '\xA0' ); 
		$_
	} @v;

	my %d;
	@d{ @h } = @v;

	return Net::AnywhereUSB::System::Information->new( %d )
}

sub network_information {
	return $_[0]->__network_information
}

sub __network_information {
	my $self = shift;

	my $s = $self->__tb->parse_content( $self->__get( __network_information_uri() ) );

	my @h = $s->look_down( _tag => 'td', class => 'field-label' );
	map {
		$_ = $_->as_trimmed_text( extra_chars => '\xA0' );
		$_ =~ s/://;
		$_ =~ tr/A-Z ./a-z_/s;
		$_
	} @h;

	my @v = $s->look_down( _tag => 'td', class => qr/field-value.*/ );
	map {
		$_ = $_->as_trimmed_text( extra_chars => '\xA0' ); 
		$_
	} @v;

	my %d;
	@d{ @h } = @v;

	return Net::AnywhereUSB::System::Network->new( %d )
}

sub __get {
	my ( $self, $uri ) = @_;

	{
	no warnings 'redefine';

	sub LWP::UserAgent::get_basic_credentials {
		my ($self, $realm, $url) = @_;

		return $self->{ opts }->{ username }, $self->{ opts }->{ password }
	}
	}

	$uri = $self->{ opts }->{ proto }
		. '://'
		. $self->{ opts }->{ username }
		. ':'
		. $self->{ opts }->{ password }
		. '@'
		. $self->{ opts }->{ server }
		. $uri;

	my $r = $self->__ua->get( $uri );

	$r->is_success 
		? return $r->decoded_content
		: die "Unable to retrieve uri: $uri\n";
}

sub __home_uri {
	return '/home.htm'
}

sub __system_information_uri {
	return '/admin/sysinfo/general_stats.htm'
}

sub __network_information_uri {
	return '/admin/sysinfo/network_stats.htm'
}

sub __ua {
	return $_[0]->{ __ua }
}

sub __tb {
	return $_[0]->{ __tb }
}

1;

__END__

=pod

=head1 NAME

Net::AnywhereUSB - Simple Perl interface to Digi AnywhereUSB devices.

=head1 SYNOPSIS

This module provides a simple interface for monitoring Digi AnywhereUSB 
devices.

    use Net::AnywhereUSB;

    my $n = Net::AnywhereUSB->new(
        username => 'root',
        password => 'p@55w0rd',
        server   => 'my-usb-anywhere-device.domian.com'
    );

    # Print some basic system information
    my $sysinfo = $n->system_information();
    printf( "Model: %s - Firmware: %s\nUptime: %s\n",
            $sysinfo->model,
            $sysinfo->firmware_version,
            $sysinfo->up_time
    );

    # Check and report on memory consumption
    if ( ( ( $sysinfo->used_memory->value 
             / $sysinfo->total_memory->value ) * 100 ) >= 85 ) {
        print "Memory consumption exceeds 85%\n";
        # send alert or take action ...
    }
    
    ...

=head1 METHODS

=head2 new ( %args )

Constructor; creates a new Net::AnywhereUSB object representing a connection to
a Digi Anywhere USB device.  the constructor takes three mandatory and three
optional parameters.  The three mandatory parameters are:

=over 3

=item username

The username with which to authenticate to the device.

=item password

The password with which to authenticate to the device.

=item server

The hostname or IP address of the Dig AnywhereUSB device.

=back

The three optional parameters are:

=over 3

=item timeout

The timeout period in seconds to use when establising a connection to the Digi
AnywhereUSB device.  Defaults to 10 seconds.

=item proto

The protocol to use when connecting to the Digi AnywhereUSB device - either one
of http or https.  Defaults to https.

=item ssl_verify

A boolean value indicating if the module shoud verify the validity of the Digi
AnywhereUSB device SSL certificate.  Defaults to false (don't verify).

=back

=head2 summary ( )

Returns summary information of the Digi AnywhereUSB device as a 
L<Net::AnywhereUSB::System::Summary> object.

=head2 system_information ( )

Returns detailed system information for the Digi AnywhereUSB device as a
L<Net::AnywhereUSB::System::Information> object.

=head2 network_information ( )

Returns detailed network information for the Digi AnywhereUSB device as a
L<Net::AnywhereUSB::Network::Information> object.


=head1 AUTHOR

Luke Poskitt, C<< <luke.poskitt at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-Net-anywhereusb at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-AnywhereUSB>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::AnywhereUSB

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-AnywhereUSB>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-AnywhereUSB>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-AnywhereUSB>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-AnywhereUSB/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2019 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

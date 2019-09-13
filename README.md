## NAME

Net::AnywhereUSB - Simple Perl interface to Digi AnywhereUSB devices.

## SYNOPSIS

This module provides a simple interface for monitoring Digi AnywhereUSB 
devices.

    ```perl
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
    ```

## METHODS

### new ( %args )

Constructor; creates a new Net::AnywhereUSB object representing a connection to
a Digi Anywhere USB device.  the constructor takes three mandatory and three
optional parameters.  The three mandatory parameters are:

- username

    The username with which to authenticate to the device.

- password

    The password with which to authenticate to the device.

- server

    The hostname or IP address of the Dig AnywhereUSB device.

The three optional parameters are:

- timeout

    The timeout period in seconds to use when establising a connection to the Digi
    AnywhereUSB device.  Defaults to 10 seconds.

- proto

    The protocol to use when connecting to the Digi AnywhereUSB device - either one
    of http or https.  Defaults to https.

- ssl\_verify

    A boolean value indicating if the module shoud verify the validity of the Digi
    AnywhereUSB device SSL certificate.  Defaults to false (don't verify).

### summary ( )

Returns summary information of the Digi AnywhereUSB device as a 
[Net::AnywhereUSB::System::Summary](https://metacpan.org/pod/Net::AnywhereUSB::System::Summary) object.

### system\_information ( )

Returns detailed system information for the Digi AnywhereUSB device as a
[Net::AnywhereUSB::System::Information](https://metacpan.org/pod/Net::AnywhereUSB::System::Information) object.

### network\_information ( )

Returns detailed network information for the Digi AnywhereUSB device as a
[Net::AnywhereUSB::Network::Information](https://metacpan.org/pod/Net::AnywhereUSB::Network::Information) object.

## AUTHOR

Luke Poskitt, `<luke.poskitt at gmail.com>`

## BUGS

Please report any bugs or feature requests to `bug-Net-anywhereusb at rt.cpan.org`, or through
the web interface at [http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-AnywhereUSB](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-AnywhereUSB).  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

## SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::AnywhereUSB

You can also look for information at:

- RT: CPAN's request tracker (report bugs here)

    [http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-AnywhereUSB](http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-AnywhereUSB)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/Net-AnywhereUSB](http://annocpan.org/dist/Net-AnywhereUSB)

- CPAN Ratings

    [http://cpanratings.perl.org/d/Net-AnywhereUSB](http://cpanratings.perl.org/d/Net-AnywhereUSB)

- Search CPAN

    [http://search.cpan.org/dist/Net-AnywhereUSB/](http://search.cpan.org/dist/Net-AnywhereUSB/)

## LICENSE AND COPYRIGHT

Copyright 2019 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

[http://www.perlfoundation.org/artistic\_license\_2\_0](http://www.perlfoundation.org/artistic_license_2_0)

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

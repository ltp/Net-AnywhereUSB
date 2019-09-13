use strict;
use warnings;
use Test::More;

unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => "Author tests not required for installation" );
}

# Ensure a recent version of Test::Pod::Coverage
my $min_tpc = 1.08;
eval "use Test::Pod::Coverage $min_tpc";
plan skip_all => "Test::Pod::Coverage $min_tpc required for testing POD coverage"
    if $@;

my $min_pc = 0.18;
eval "use Pod::Coverage $min_pc";

if ( $@ ) {
	plan skip_all => "Pod::Coverage $min_pc required for testing POD coverage"
}
else {
	plan tests => 5
}

pod_coverage_ok( 'Net::AnywhereUSB' );
pod_coverage_ok( 'Net::AnywhereUSB::Common::Value',		{ also_private => [ 'new' ] } );
pod_coverage_ok( 'Net::AnywhereUSB::System::Information',	{ also_private => [ 'new' ] } );
pod_coverage_ok( 'Net::AnywhereUSB::System::Network',		{ also_private => [ 'new' ] } );
pod_coverage_ok( 'Net::AnywhereUSB::System::Summary',		{ also_private => [ 'new' ] } );

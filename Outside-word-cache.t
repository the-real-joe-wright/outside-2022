#!/usr/local/bin/perl

use strict;
use v5.30;

use Test::More 'no_plan';

use lib ".";

use_ok( "Outside" );


# Verify that the lookup cache works as expected
my @test_words = (
    "Lunita",
    "jnbgyujk",
    "Lunita",
    "it's",
    "jnbgyujk",
);

my %test_words = (
    "Lunita" => 1,
    "jnbgyujk" => 0,
    "it's" => 1,
);

foreach my $w (@test_words) {
    diag( "Checking word spelling: $w" );
    my $res = check_word_spelling($w);
    ok( $res == $test_words{$w} );
}

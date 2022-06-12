#!/usr/local/bin/perl

use strict;
use v5.30;

use Test::More 'no_plan';

use lib ".";

use_ok( "Outside" );

# Test the results of the spelling API
my %test_words = (
    "Lunita" => 1,
    "jnbgyujk" => 0,
    "it's" => 1,
    "ocean's" => 1,
    "upside-down" => 1,
    "upside" => 1,
    "wet-exited" => 1,
    "wet" => 1,
    "exited" => 1,
    "jnhgyujkiuj-exited" => 0,
    "exited-jhgtyuj" => 0,
);

while( my ($k, $v) = each %test_words) {
    diag( "Checking word spelling: $k" );
    my $res = check_word_spelling($k);
    ok( $res == $v );
}


# Test the word normalization routine
my %test_normalize_words = (
    "testword" => "testword",
    "it's" => "it's",
    "Hello!" => "Hello",
    "\"Lunita" => "Lunita",
    "Lunita." => "Lunita",
    "wet-exit" => "wet exit",
);

while( my ($k, $v) = each %test_normalize_words) {
    diag( "Checking word spelling: $k" );
    my $res = normalize_word($k);
    ok( $res == $v );
}

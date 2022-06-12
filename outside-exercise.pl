#!/usr/local/bin/perl
use strict;
use warnings;
use v5.30;

use Digest::MD5 qw(md5_hex);

use lib ".";
use Outside;


sub main {
    # read the document
    my @data = get_document();

    # mash the document into a flat array of words
    my @raw_words;
    foreach my $l ( @data ) {
        chomp $l;
        push @raw_words, split(/\s+/, $l);
    }

    my @misspelled_words;
    foreach my $w ( @raw_words ) {
        if( check_word_spelling($w) == 0 ) {
            say "!!! MISSPELLED WORD: |$w|";
            push(@misspelled_words, normalize_word($w));
        }
    }

    if ( @misspelled_words ) {
        say "Found misspelled words:";
        foreach my $w ( @misspelled_words ) {
            say "$w";
        }
        say join("", @misspelled_words);
        my $miss_string = join("", @misspelled_words);
        my $md5_string = md5_hex($miss_string);
        say "md5_string: $md5_string";
    }
}

main;

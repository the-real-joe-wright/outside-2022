package Outside;

use strict;
use warnings;
use v5.30;

use Exporter 'import';
our @EXPORT = qw( check_word_spelling get_document normalize_word );
our @EXPORT_OK = qw(  );


# Lookup cache to save time on API lookups
my %word_cache;


# pull the document from Outside's API
sub get_document {
    my $api_prefix = "https://outside-interview.herokuapp.com";
    my @document = qx(curl --silent $api_prefix/document);

    return @document;
}


sub normalize_word {
    my $raw_word = shift;

    # Remove all punctuation except apostrophe and hyphen
    $raw_word =~ s/[^a-zA-Z0-9'-]//g;

    # replace hyphen with space
    $raw_word =~ s/-/ /g;

    return $raw_word;
}


sub check_word_spelling {
    my $word = shift;

    # normalize the word
    my $normalized_word = normalize_word($word);

    # is $normalized_word in the cache?
    if( defined($word_cache{$normalized_word}) ) {
        # if so, skip the API lookup and return the cache value instead
        return $word_cache{$normalized_word};
    }

    # hyphenated words are split into two for separate lookups
    my @normalized_words = split(/\s+/, normalize_word($word));

    my $result = 1;  # innocent until proven guilty

    my $spellcheck_url = "http://outside-interview.herokuapp.com/spelling";

    foreach my $w ( @normalized_words ) {
        # curl the API and return the first line of the result
        my $r = qx(curl -I --silent "$spellcheck_url/$w" | head -1);

        chomp $r;

        if ($r =~ /HTTP\/1.1 204 No Content/) {
            next;
        }
        elsif ($r =~ /HTTP\/1.1 404 Not Found/) {
            $result = 0; 

            # if the first word of a hyphenated pair is bad, skip the second word:
            last;
        } 
        else {
            # If anything other than 204 or 404, exit
            say "INDETERMINATE RESULT FOR WORD $w";
            say $r;
            exit;
        }

    }

    # Load the result into the lookup cache
    $word_cache{$normalized_word} = $result;

    return $result;
}

1;

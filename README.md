# outside-2022

This code was written 2022-06-11 for the Outside programming exercise.

## To run the exercise: 
`perl outside-exercise.pl`

## To run the tests: 
`perl Outside.t`

## Hyphenated string handling:
The spell checking loop treats two hyphenated words as one item, and checks each component.  If one of the words is misspelled, the entire hyphenated word is considered to be misspelled.

## Areas for improvement:
- The slowest part of the process is the hundreds of API calls.  This could be sped up by running multiple simultaneous curl calls.

## Why Perl?  
Because it's a good language for prototyping and for fast development.

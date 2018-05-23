#!/usr/bin/env perl6

use v6;
use Test;
use lib 'lib';
use Test-Files;

=begin overview

Insure any text that mentions Perl uses a no-break space after it.

=end overview

my @files = Test-Files.documents;

my %variants = %( "file handle" | "file-handle" => "filehandle" );
plan +@files;

for @files.sort -> $file {
    my $ok = True;
    my $row = 0;
    my @bad;
    for $file.IO.slurp.lines -> $line {
        $row++;
        next if $line ~~ / ^ \s+ /;
        for %variants.keys -> $rx {
            if $line ~~ m:g/ $rx / {
                $ok = False;
                @bad.push: "«$0» found in line $row. We prefer ｢%variants{$rx}｣";
            }
        }
    }
    my $error = $file;
    if !$ok {
        $error ~= " {@bad.join: ', '})";
    }
    ok $ok, "$error: Certain words should be normalized." ;
}

# vim: expandtab shiftwidth=4 ft=perl6
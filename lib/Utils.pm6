unit class Utils;

=begin overview

Miscellaneous methods used by htmlify

=end overview

our sub warn-user (Str $warn-text) is export {
    my $border = '=' x $warn-text.chars;
    note "\n$border\n$warn-text\n$border\n";
}

# vim: expandtab shiftwidth=4 ft=perl6

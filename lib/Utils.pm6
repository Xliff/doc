unit class Utils;

=begin overview

Miscellaneous methods used by htmlify

=end overview

#| Emit a block of text surrounded by #'s
our sub warn-user (Str $warn-text) is export {
    my $border = '=' x $warn-text.chars;
    note "\n$border\n$warn-text\n$border\n";
}

#| Given the name of a directory, return the names of all the files under it (inc. subdirs)
sub recursive-dir($dir) is export {
    my @todo = $dir;
    gather while @todo {
        my $d = @todo.shift;
        for dir($d) -> $f {
            if $f.f {
                take $f;
            }
            else {
                @todo.append: $f.path;
            }
        }
    }
}

# vim: expandtab shiftwidth=4 ft=perl6

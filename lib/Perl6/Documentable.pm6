use URI::Escape;
class Perl6::Documentable {
    has     $.kind;        # type, language doc, routine, module
    has     @.subkinds;    # class/role/enum, sub/method, prefix/infix/...
    has     @.categories;  # basic type, exception, operator...

    has     $.name;
    has     $.url;
    has     $.pod;
    has     $.pod-is-complete;
    has     $.summary = '';

    # the Documentable that this one was extracted from, if any
    has $.origin;

    # Remove itemization from incoming arrays
    method new (:$categories = [], :$subkinds = [], *%_) {
        nextwith |%_, :categories($categories.list), :subkinds($subkinds.list);
    }

    my sub english-list (*@l) {
        @l > 1
            ?? @l[0..*-2].join(', ') ~ " and @l[*-1]"
            !! ~@l[0]
    }
    method human-kind() {   # SCNR
        $.kind eq 'language'
            ?? 'language documentation'
            !! @.categories eq 'operator'
            ?? "@.subkinds[] operator"
            !! english-list @.subkinds // $.kind;
    }

    method url() {
        $!url //= $.kind eq 'operator'
            ?? "/language/operators#" ~ uri_escape("@.subkinds[] {$.name.gist}".subst(/\s+/, '_', :g))
            !! ("", $.kind, $.name.gist).map(&uri_escape).join('/')
            ;
    }
    method categories() {
        @!categories //= @.subkinds
    }
}

# vim: expandtab shiftwidth=4 ft=perl6

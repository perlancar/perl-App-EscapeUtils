package App::EscapeUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

our %arg_strings = (
    strings => {
        'x.name.is_plural' => 1,
        'x.name.singular' => 'string',
        schema => ['array*', of=>'str*'],
        req => 1,
        pos => 0,
        greedy => 1,
        cmdline_src => 'stdin_or_args',
        stream => 1,
    },
);

$SPEC{uri_escape} = {
    v => 1.1,
    args => {
        %arg_strings,
    },
    result => {
        schema => ['array*', of=>'str*'],
        stream => 1,
    },
};
sub uri_escape {
    require URI::Escape;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = <$strings>;
        if (defined $str) {
            return URI::Escape::uri_escape($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

1;
#ABSTRACT: Various string escaping/unescaping utilities

=head1 DESCRIPTION

This distributions provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

=cut

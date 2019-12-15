package App::EscapeUtils;

# AUTHORITY
# DATE
# DIST
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
    summary => 'URI-escape lines of input (in standard input or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub uri_escape {
    require URI::Escape;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return URI::Escape::uri_escape($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{uri_unescape} = {
    v => 1.1,
    summary => 'URI-unescape lines of input (in standard input or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub uri_unescape {
    require URI::Escape;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return URI::Escape::uri_unescape($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{js_escape} = {
    v => 1.1,
    summary => 'Encode lines of input (in standard input or arguments) '.
        'as JSON strings',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub js_escape {
    require String::JS;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::JS::encode_js_string($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{js_unescape} = {
    v => 1.1,
    summary => 'Interpret lines of input (in standard input or arguments) as '.
        'JSON strings and return the decoded value',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub js_unescape {
    require String::JS;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::JS::decode_js_string($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{backslash_escape} = {
    v => 1.1,
    summary => 'Escape lines of input using backslash octal sequence '.
        '(or \\r, \\n, \\t)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub backslash_escape {
    require String::Escape;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::Escape::backslash($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{backslash_unescape} = {
    v => 1.1,
    summary => 'Restore backslash octal sequence (or \\r, \\n, \\t) to '.
        'original characters in lines of input (in stdin or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub backslash_unescape {
    require String::Escape;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::Escape::unbackslash($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{html_escape} = {
    v => 1.1,
    summary => 'HTML-escape lines of input (in stdin or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub html_escape {
    require HTML::Entities;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return HTML::Entities::encode_entities($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{html_unescape} = {
    v => 1.1,
    summary => 'HTML-unescape lines of input (in stdin or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub html_unescape {
    require HTML::Entities;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return HTML::Entities::decode_entities($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{shell_escape} = {
    v => 1.1,
    summary => 'Shell-escape lines of input (in stdin or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub shell_escape {
    require ShellQuote::Any::Tiny;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return ShellQuote::Any::Tiny::shell_quote($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{pod_escape} = {
    v => 1.1,
    summary => 'Quote POD special characters in input (in stdin or arguments)',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub pod_escape {
    require String::PodQuote;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::PodQuote::pod_quote($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{perl_dquote_escape} = {
    v => 1.1,
    summary => 'Encode lines of input (in stdin or arguments) inside Perl double-quoted strings',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub perl_dquote_escape {
    require String::PerlQuote;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::PerlQuote::double_quote($str);
        } else {
            return undef;
        }
    };

    return [200, "OK", $cb];
}

$SPEC{perl_squote_escape} = {
    v => 1.1,
    summary => 'Encode lines of input (in stdin or arguments) inside Perl single-quoted strings',
    args => {
        %arg_strings,
    },
    result => {
        schema => 'str*',
        stream => 1,
    },
};
sub perl_squote_escape {
    require String::PerlQuote;

    my %args = @_;

    my $strings = $args{strings};
    my $cb = sub {
        my $str = $strings->();
        if (defined $str) {
            return String::PerlQuote::single_quote($str);
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

L<URI::Escape>

L<String::JS>

L<String::Escape>

L<HTML::Entities>

L<String::ShellQuote> and L<ShellQuote::Any::Tiny>

L<String::xcPodQuote>

L<String::PerlQuote>

=cut

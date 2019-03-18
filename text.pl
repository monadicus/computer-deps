%
%  text.pl
%
%  Text processing utilities.
%

pip_pkg(nltk).

meta_pkg(malt, [
    '__malt binary',
    '__malt model'
]).

command_pkg('__malt binary', malt).
meet('__malt binary', _) :-
    ( isdir('~/.computer/maltparser-1.7.1') ->
        true
    ;
        curl(
            'http://www.maltparser.org/dist/maltparser-1.7.1.tar.gz',
            '~/.computer/maltparser-1.7.1.tar.gz'
        ),
        bash('cd ~/.computer && tar xfz maltparser-1.7.1.tar.gz'),
        bash('rm -f ~/.computer/maltparser-1.7.1.tar.gz')
    ),
    expand_path('~/.computer/bin/malt', F),
    ( \+ isfile(F) ->
        tell(F),
        writeln('#!/bin/bash'),
        writeln('exec java -jar ~/.computer/maltparser-1.7.1/maltparser-1.7.1.jar "$@"'),
        told
    ;
        true
    ),
    bash('chmod a+x ~/.computer/bin/malt').

pkg('__malt model').
met('__malt model', _) :- isfile('~/.computer/maltparser-1.7.1-models/engmalt.poly-1.7.mco').
meet('__malt model', _) :-
    bash('mkdir -p ~/.computer/maltparser-1.7.1-models'),
    curl(
        'http://www.maltparser.org/mco/english_parser/engmalt.poly-1.7.mco',
        '~/.computer/maltparser-1.7.1-models/engmalt.poly-1.7.mco'
    ).

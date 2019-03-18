%
%  golang.pl
%  computer-deps
%

meta_pkg(golang, [
    '__golang source fetched',
    '__golang built'
]).


pkg('__golang source fetched').
met('__golang source fetched', _) :-
    isdir('~/.computer/go').
meet('__golang source fetched', _) :-
    bash('mkdir -p ~/.computer'),
    bash('cd ~/.computer && curl https://go.googlecode.com/files/go1.1.src.tar.gz | tar xz').

pkg('__golang built').
met('__golang built', _) :-
    isfile('~/.computer/go/bin/go').
meet('__golang built', _) :-
    bash('cd ~/.computer/go/src && ./all.bash').

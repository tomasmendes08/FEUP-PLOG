:-set_prolog_flag(legacy_char_classification, on).

initial(
[[green, white, black, green, black, green],
[black, green, green, white, green, white],
[green, white, black, green, black, green],
[black, white, green, green, green, white],
[green, green, green, green, white, black],
[white, white, black, green, black, green]]).

symbol(black, S):- S='B'.
symbol(white, S):- S='W'.
symbol(green, S):- S='G'.
symbol(empty, S):- S=' '.

printBoard(B):-
    nl,
    write('   | 0 | 1 | 2 | 3 | 4 | 5 |\n'),
    write('---|---|---|---|---|---|---|\n'),
    printLines(B, 0).

/*X representa o nmr da linha*/
printLines([], 6).
printLines([H|T], X):-
    write(' '),
    write(X),
    write(' '),
    write('| '),
    printLinesAux(H),
    nl,
    write('---|---|---|---|---|---|---|\n'),
    X1 is X + 1,
    printLines(T, X1).

printLinesAux([]).
printLinesAux([H|T]):-
    symbol(H, S),
    write(S),
    write(' | '),
    printLinesAux(T).

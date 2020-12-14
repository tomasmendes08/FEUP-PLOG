initialBoard([
[1, ' ', 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0],
[1, 0, 0, 1, 0 ,1, 0, 0]
]).

start:-
    initialBoard(B),
    printBoard(B).

printBoard(B):-
    nl,
    write('     |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |\n'),
    write('-----|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    printLines(B, 1).

/*X representa o nmr da linha*/
printLines([], 9).
printLines([H|T], X):-
    write('  '),
    write(X),
    write(' '),
    write(' |  '),
    printLinesAux(H),
    nl,
    write('-----|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    X1 is X + 1,
    printLines(T, X1).

printLinesAux([]).
printLinesAux([H|T]):-
    write(H),
    write('  |  '),
    printLinesAux(T).

initialBoard([
[[green,1], [white,0], [black,0], [green,1], [black,0], [green,1]],
[[black,0], [green,1], [green,1], [white,0], [green,1], [white,0]],
[[green,1], [white,0], [black,0], [green,1], [black,0], [green,1]],
[[black,0], [white,0], [green,1], [green,1], [green,1], [white,0]],
[[green,1], [green,1], [green,1], [green,1], [white,0], [black,0]],
[[white,0], [white,0], [black,0], [green,1], [black,0], [green,1]]
]).

symbol(black, S):- S='B0'.
symbol(white, S):- S='W0'.
symbol(green, S):- S='G1'.
symbol(empty, S):- S=' '.

printBoard(B):-
    nl,
    write('    |  0 |  1 |  2 |  3 |  4 |  5 |\n'),
    write('----|----|----|----|----|----|----|\n'),
    printLines(B, 0).

/*X representa o nmr da linha*/
printLines([], 6).
printLines([H|T], X):-
    write(' '),
    write(X),
    write(' '),
    write(' | '),
    printLinesAux(H),
    nl,
    write('----|----|----|----|----|----|----|\n'),
    X1 is X + 1,
    printLines(T, X1).

printLinesAux([]).
printLinesAux([H|T]):-
    printCell(H),
    write(' | '),
    printLinesAux(T).

printCell([H|T]):-
    symbol(H, S),
    write(S).
    

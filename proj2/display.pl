initialBoard([
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ', 4 ,' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ', 4 ,' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[ 0 ,' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ', 4 ,' ',' ',' ',' ',' ']
]).

testBoard([
[ 1 , 0 , 1 ],
[ 1 , 1 , 0 ],
[' ', 1 , 1 ]
]).

start:-
    initialBoard(B),
    printBoard(B).

start2:-
    testBoard(B),
    printBoard(B),
    place_Piece(B, 'Q'),

print_matrix([]).
print_matrix([H|T]) :- write(H), nl, print_matrix(T).

printBoard(B):-
    nl,
    write('|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    printLines(B, 1).

/*X representa o nmr da linha*/
printLines([], 4).
printLines([H|T], X):-
    write('|  '),
    printLinesAux(H),
    nl,
    write('|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    X1 is X + 1,
    printLines(T, X1).

printLinesAux([]).
printLinesAux([H|T]):-
    write(H),
    write('  |  '),
    printLinesAux(T).

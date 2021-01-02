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

/*
testBoard([
[0, 1, 0, 6, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 2, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0]
]).
*/

% Algo do genero [1, 1, 0] (por um 1 na posição 1,0)
% [6, 3, 0], [2, 4, 2], [0, 3, 4]

testBoard([[1, 1, 0], [6, 3, 0], [2, 4, 2], [0, 3, 4]]).

startBoard([
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0]
]).

start:-
    initialBoard(B),
    printBoard(B).

start2:-
    startBoard(B),
    printBoard(B),
    placeAttacks(B).

print_matrix([]).
print_matrix([H|T]) :- write(H), nl, print_matrix(T).

printBoard(B):-
    nl,
    write('|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    printLines(B, 1).

/*X representa o nmr da linha*/
printLines([], 9).
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

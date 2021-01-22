testBoard1([[1, 0, 1], [3, 0, 4]]).

testBoard2([[2, 0, 4], [5, 3, 1]]).

testBoard3([[1, 1, 2], [4, 3, 3]]).

testBoard4([[5, 5, 2], [2, 3, 3]]).

testBoard5([[4, 0, 2], [2, 1, 3], [3, 3, 2]]).

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

start(1):-
    startBoard(B),
    testBoard1(Input),
    placeAttacks(B, Input).

start(2):-
    startBoard(B),
    testBoard2(Input),
    placeAttacks(B, Input).

start(3):-
    startBoard(B),
    testBoard3(Input),
    placeAttacks(B, Input).

start(4):-
    startBoard(B),
    testBoard4(Input),
    placeAttacks(B, Input).

start(5):-
    startBoard(B),
    testBoard5(Input),
    placeAttacks(B, Input).


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

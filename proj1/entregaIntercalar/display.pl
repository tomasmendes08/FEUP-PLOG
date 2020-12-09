%initial board and potential mid and end game boards
initialBoard([
[[green,1], [white,0], [black,0], [green,1], [black,0], [green,1]],
[[black,0], [green,1], [green,1], [white,0], [green,1], [white,0]],
[[green,1], [white,0], [black,0], [green,1], [black,0], [green,1]],
[[black,0], [white,0], [green,1], [green,1], [green,1], [white,0]],
[[green,1], [green,1], [green,1], [green,1], [white,0], [black,0]],
[[white,0], [white,0], [black,0], [green,1], [black,0], [green,1]]
]).

midgameBoard([
[[white,2], [empty,0], [empty,0], [empty,0], [black,0], [green,1]],
[[black,0], [green,1], [green,1], [empty,0], [white,2], [empty,0]],
[[green,1], [white,0], [black,0], [empty,0], [black,0], [green,1]],
[[empty,0], [white,0], [green,1], [green,1], [green,1], [black,0]],
[[empty,0], [green,1], [green,1], [white,2], [empty,0], [empty,0]],
[[black,0], [white,0], [black,0], [green,1], [black,0], [green,1]]
]).

endgameBoard([
[[empty,0], [empty,0], [empty,0], [empty,0], [empty,0], [green,1]],
[[empty,0], [white,8], [empty,0], [empty,0], [empty,0], [empty,0]],
[[empty,0], [empty,0], [empty,0], [empty,0], [empty,0], [empty,0]],
[[empty,0], [empty,0], [black,6], [empty,0], [empty,0], [empty,0]],
[[empty,0], [empty,0], [empty,0], [empty,0], [black,3], [empty,0]],
[[empty,0], [empty,0], [empty,0], [empty,0], [empty,0], [empty,0]]
]).


%All symbols that can be used
symbol(green, 1, S):- S='G1'.
symbol(empty, 0, S):- S='  '.

symbol(black, 0, S):- S='B0'.
symbol(black, 1, S):- S='B1'.
symbol(black, 2, S):- S='B2'.
symbol(black, 3, S):- S='B3'.
symbol(black, 4, S):- S='B4'.
symbol(black, 5, S):- S='B5'.
symbol(black, 6, S):- S='B6'.
symbol(black, 7, S):- S='B7'.
symbol(black, 8, S):- S='B8'.
symbol(black, 9, S):- S='B9'.
symbol(black, 10, S):- S='B10'.
symbol(black, 11, S):- S='B11'.
symbol(black, 12, S):- S='B12'.

symbol(white, 0, S):- S='W0'.
symbol(white, 1, S):- S='W1'.
symbol(white, 2, S):- S='W2'.
symbol(white, 3, S):- S='W3'.
symbol(white, 4, S):- S='W4'.
symbol(white, 5, S):- S='W5'.
symbol(white, 6, S):- S='W6'.
symbol(white, 7, S):- S='W7'.
symbol(white, 8, S):- S='W8'.
symbol(white, 9, S):- S='W9'.
symbol(white, 10, S):- S='W10'.
symbol(white, 11, S):- S='W11'.
symbol(white, 12, S):- S='W12'.

%prints the columns' indexes and call printLines
printBoard(B):-
    nl,
    write('    |  0 |  1 |  2 |  3 |  4 |  5 |\n'),
    write('----|----|----|----|----|----|----|\n'),
    printLines(B, 0).

%formats the rows' indexes and calls printLinesAux
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

%prints the entire line passed as a list
printLinesAux([]).
printLinesAux([H|T]):-
    printCell(H),
    write(' | '),
    printLinesAux(T).

%prints the content of each cell
printCell([H|[H2|_]]):-
    symbol(H, H2, S),
    write(S).
    

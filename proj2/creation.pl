


place_Piece(Board, Piece):-
    queenAttack(Board, 4, 2, Board1),
    rookAttack(Board1, 6, 3, Board2),
    bishopAttack(Board2, 2, 2, EndBoard),
    printBoard(EndBoard).



% GET THE CELL AT CERTAIN COORDINATES

getMatrixAt(Row, Col, Matrix, Cell):-
  nth0(Row, Matrix, MatrixRow),
  nth0(Col, MatrixRow, Cell).


% REPLACE CELL WITH PIECE

replace( [L|Ls] , 0 , Y , Piece , [R|Ls] ) :-   % once we find the desired row,
  replace_column(L,Y,Piece,R).                      % - we replace specified column, and we're done.


replace( [L|Ls] , X , Y , Z , [L|Rs] ) :-       % if we haven't found the desired row yet
  X > 0 ,                                       % - and the row offset is positive,
  X1 is X-1 ,                                   % - we decrement the row offset
  replace( Ls , X1 , Y , Z , Rs ).              % - and recurse down


replace_column( [_|Cs] , 0 , Z , [Z|Cs] ) .     % once we find the specified offset, just make the substitution and finish up.
replace_column( [C|Cs] , Y , Z , [C|Rs] ) :-    % otherwise,
  Y > 0 ,                                       % - assuming that the column offset is positive,
  Y1 is Y-1 ,                                   % - we decrement it
  replace_column( Cs , Y1 , Z , Rs ).           % - and recurse down.


% ADDS QUEEN ATTACKS

queenAttack(Board, X, Y, EndBoard):-
    attackRow(Board, X, Y, Board1),
    attackColumn(Board1, X, Y, Board2),
    attackDiagonal(Board2, X, Y, Board3),
    replace(Board3, Y, X, 'Q', EndBoard).

rookAttack(Board, X, Y, EndBoard):-
    attackRow(Board, X, Y, Board1),
    attackColumn(Board1, X, Y, Board2),
    replace(Board2, Y, X, 'R', EndBoard).

bishopAttack(Board, X, Y, EndBoard):-
    attackDiagonal(Board, X, Y, Board1),
    replace(Board1, Y, X, 'B', EndBoard).



% ATTACK LINE

attackRow(Board, X, Y, EndBoard):-
  attackRowNeg(Board, X, Y, NewBoard),
  attackRowPos(NewBoard, X, Y, EndBoard).

attackRowNeg(Board, 0, _, Board).

attackRowNeg(Board, X, Y, EndBoard):-
  X1 is X-1,
  getMatrixAt(Y, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, NewBoard),!,
  attackRowNeg(NewBoard, X1, Y, EndBoard).
attackRowPos(Board, 7, _, Board).

attackRowPos(Board, X, Y, EndBoard):-
  X1 is X + 1,
  getMatrixAt(Y, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, NewBoard),!,
  attackRowPos(NewBoard, X1, Y, EndBoard).

% ATTACK COLUMN

attackColumn(Board, X, Y, EndBoard):-
  attackColumnNeg(Board, X, Y, NewBoard),
  attackColumnPos(NewBoard, X, Y, EndBoard).

attackColumnNeg(Board, _, 0, Board).

attackColumnNeg(Board, X, Y, EndBoard):-
  Y1 is Y-1,
  getMatrixAt(Y1, X, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, NewBoard),!,
  attackColumnNeg(NewBoard, X, Y1, EndBoard).

attackColumnPos(Board, _, 7, Board).

attackColumnPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  getMatrixAt(Y1, X, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, NewBoard),!,
  attackColumnPos(NewBoard, X, Y1, EndBoard).


% ATTACK DIAGONAL

attackDiagonal(Board, X, Y, EndBoard):-
  attackDiagonalLeftNeg(Board, X, Y, Board1),
  attackDiagonalRightNeg(Board1, X, Y, Board2),
  attackDiagonalLeftPos(Board2, X, Y, Board3),
  attackDiagonalRightPos(Board3, X, Y, EndBoard).

attackDiagonalLeftPos(Board, _, 7, Board).
attackDiagonalLeftPos(Board, 0, _, Board).

attackDiagonalLeftPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  X1 is X - 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  attackDiagonalLeftPos(NewBoard, X1, Y1, EndBoard).

attackDiagonalRightPos(Board, _, 7, Board).
attackDiagonalRightPos(Board, 7, _, Board).

attackDiagonalRightPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  X1 is X + 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  attackDiagonalRightPos(NewBoard, X1, Y1, EndBoard).

attackDiagonalLeftNeg(Board, _, 0, Board).
attackDiagonalLeftNeg(Board, 0, _, Board).

attackDiagonalLeftNeg(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  X1 is X - 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  attackDiagonalLeftNeg(NewBoard, X1, Y1, EndBoard).

attackDiagonalRightNeg(Board, _, 0, Board).
attackDiagonalRightNeg(Board, 7, _, Board).

attackDiagonalRightNeg(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  X1 is X + 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  attackDiagonalRightNeg(NewBoard, X1, Y1, EndBoard).






row(N, Matrix, Row):-
  nth0(N, Matrix, Row).

col(N, Matrix, Col):-
  maplist(nth0(N), Matrix, Col).



place_Piece(Board, Piece):-
    queenAttack(Board, 4, 2, NewBoard),
    %towerAttack(Board, 6, 3, NewBoard),
    printBoard(NewBoard).



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
    queenAttackRow(Board, X, Y, Board1),
    queenAttackColumn(Board1, X, Y, Board2),
    queenAttackDiagonal(Board2, X, Y, Board3),
    replace(Board3, Y, X, 'Q', EndBoard).




% QUEEN LINE

queenAttackRow(Board, X, Y, EndBoard):-
  queenAttackRowNeg(Board, X, Y, NewBoard),
  queenAttackRowPos(NewBoard, X, Y, EndBoard).

queenAttackRowNeg(Board, 0, _, Board).

queenAttackRowNeg(Board, X, Y, EndBoard):-
  X1 is X-1,
  getMatrixAt(Y, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, NewBoard),!,
  queenAttackRowNeg(NewBoard, X1, Y, EndBoard).

queenAttackRowPos(Board, 7, _, Board).

queenAttackRowPos(Board, X, Y, EndBoard):-
  X1 is X + 1,
  getMatrixAt(Y, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, NewBoard),!,
  queenAttackRowPos(NewBoard, X1, Y, EndBoard).

% QUEEN COLUMN

queenAttackColumn(Board, X, Y, EndBoard):-
  queenAttackColumnNeg(Board, X, Y, NewBoard),
  queenAttackColumnPos(NewBoard, X, Y, EndBoard).

queenAttackColumnNeg(Board, _, 0, Board).

queenAttackColumnNeg(Board, X, Y, EndBoard):-
  Y1 is Y-1,
  getMatrixAt(Y1, X, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, NewBoard),!,
  queenAttackColumnNeg(NewBoard, X, Y1, EndBoard).

queenAttackColumnPos(Board, _, 7, Board).

queenAttackColumnPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  getMatrixAt(Y1, X, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, NewBoard),!,
  queenAttackColumnPos(NewBoard, X, Y1, EndBoard).


% QUEEN DIAGONAL

queenAttackDiagonal(Board, X, Y, EndBoard):-
  queenAttackDiagonalLeftNeg(Board, X, Y, Board1),
  queenAttackDiagonalRightNeg(Board1, X, Y, Board2),
  queenAttackDiagonalLeftPos(Board2, X, Y, Board3),
  queenAttackDiagonalRightPos(Board3, X, Y, EndBoard).

queenAttackDiagonalLeftPos(Board, _, 7, Board).
queenAttackDiagonalLeftPos(Board, 0, _, Board).

queenAttackDiagonalLeftPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  X1 is X - 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  queenAttackDiagonalLeftPos(NewBoard, X1, Y1, EndBoard).

queenAttackDiagonalRightPos(Board, _, 7, Board).
queenAttackDiagonalRightPos(Board, 7, _, Board).

queenAttackDiagonalRightPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  X1 is X + 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  queenAttackDiagonalRightPos(NewBoard, X1, Y1, EndBoard).

queenAttackDiagonalLeftNeg(Board, _, 0, Board).
queenAttackDiagonalLeftNeg(Board, 0, _, Board).

queenAttackDiagonalLeftNeg(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  X1 is X - 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  queenAttackDiagonalLeftNeg(NewBoard, X1, Y1, EndBoard).

queenAttackDiagonalRightNeg(Board, _, 0, Board).
queenAttackDiagonalRightNeg(Board, 7, _, Board).

queenAttackDiagonalRightNeg(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  X1 is X + 1,
  getMatrixAt(Y1, X1, Board, Cell),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),!,
  queenAttackDiagonalRightNeg(NewBoard, X1, Y1, EndBoard).






row(N, Matrix, Row):-
  nth0(N, Matrix, Row).

col(N, Matrix, Col):-
  maplist(nth0(N), Matrix, Col).
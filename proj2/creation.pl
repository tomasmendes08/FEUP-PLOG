


place_Piece(Board, Piece):-
    rookAttack(Board, 6, 2, Board1),
    %bishopAttack(Board2, 2, 2, Board3),
    kingAttack(Board1, 3, 3, Board2),
    queenAttack(Board2, 5, 3, Board3),
    knightAttack(Board3, 1, 5, EndBoard),
    %pawnAttack(Board1, 5, 5, EndBoard),
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

% ADDS ROOK ATTACKS

rookAttack(Board, X, Y, EndBoard):-
  attackRow(Board, X, Y, Board1),
  attackColumn(Board1, X, Y, Board2),
  replace(Board2, Y, X, 'R', EndBoard).

% ADDS BISHOP ATTACKS

bishopAttack(Board, X, Y, EndBoard):-
  attackDiagonal(Board, X, Y, Board1),
  replace(Board1, Y, X, 'B', EndBoard).

% ADDS KING ATTACKS

kingAttack(Board, X, Y, EndBoard):-
  attackLeft(Board, X, Y, Board1),
  attackRight(Board1, X, Y, Board2),
  attackUp(Board2, X, Y, Board3),
  attackDown(Board3, X, Y, Board4),
  attackUpLeft(Board4, X, Y, Board5),
  attackUpRight(Board5, X, Y, Board6),
  attackDownLeft(Board6, X, Y, Board7),
  attackDownRight(Board7, X, Y, Board8),
  replace(Board8, Y, X, 'K', EndBoard).

% ADDS PAWN ATTACKS

pawnAttack(Board, X, Y, EndBoard):-
  attackUpRight(Board, X, Y, Board1),
  attackUpLeft(Board1, X, Y, Board2),
  replace(Board2, Y, X, 'P', EndBoard).

% ADDS KNIGHT ATTACKS

knightAttack(Board, X, Y, EndBoard):-
  attackKnightUpLeft(Board, X, Y, Board1),
  attackKnightUpRight(Board1, X, Y, Board2),
  attackKnightLeftUp(Board2, X, Y, Board3),
  attackKnightLeftDown(Board3, X, Y, Board4),
  attackKnightRightUp(Board4, X, Y, Board5),
  attackKnightRightDown(Board5, X, Y, Board6),
  attackKnightDownLeft(Board6, X, Y, Board7),
  attackKnightDownRight(Board7, X, Y, Board8),
  replace(Board8, Y, X, 'H', EndBoard).



% KNIGHT ATTACK UP2 LEFT1

attackKnightUpLeft(Board, X, Y, EndBoard):-
  X1 is X - 1,
  Y1 is Y - 2,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightUpLeft(Board, _, _, Board).

% KNIGHT ATTACK UP2 RIGHT1

attackKnightUpRight(Board, X, Y, EndBoard):-
  X1 is X + 1,
  Y1 is Y - 2,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightUpRight(Board, _, _, Board).

% KNIGHT ATTACK LEFT2 UP1

attackKnightLeftUp(Board, X, Y, EndBoard):-
  X1 is X - 2,
  Y1 is Y - 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightLeftUp(Board, _, _, Board).

% KNIGHT ATTACK LEFT2 DOWN1

attackKnightLeftDown(Board, X, Y, EndBoard):-
  X1 is X - 2,
  Y1 is Y + 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightLeftDown(Board, _, _, Board).

% KNIGHT ATTACK RIGHT2 UP1

attackKnightRightUp(Board, X, Y, EndBoard):-
  X1 is X + 2,
  Y1 is Y - 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightRightUp(Board, _, _, Board).

% KNIGHT ATTACK RIGHT2 DOWN1

attackKnightRightDown(Board, X, Y, EndBoard):-
  X1 is X + 2,
  Y1 is Y + 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightRightDown(Board, _, _, Board).

% KNIGHT ATTACK DOWN2 LEFT1

attackKnightDownLeft(Board, X, Y, EndBoard):-
  X1 is X - 1,
  Y1 is Y + 2,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightDownLeft(Board, _, _, Board).

% KNIGHT ATTACK DOWN2 RIGHT1

attackKnightDownRight(Board, X, Y, EndBoard):-
  X1 is X + 1,
  Y1 is Y + 2,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackKnightDownRight(Board, _, _, Board).

% ATTACK LEFT 

attackLeft(Board, X, Y, EndBoard):-
  X1 is X - 1,
  (
  getMatrixAt(Y, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, EndBoard)
  ;
  false
  ).

attackLeft(Board, _, _, Board).

% ATTACK RIGHT 

attackRight(Board, X, Y, EndBoard):-
  X1 is X + 1,
  (
  getMatrixAt(Y, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, EndBoard)
  ;
  false
  ).

attackRight(Board, _, _, Board).

% ATTACK UP

attackUp(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  (
  getMatrixAt(Y1, X, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, EndBoard)
  ;
  false
  ).

attackUp(Board, _, _, Board).

% ATTACK DOWN

attackDown(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  (
  getMatrixAt(Y1, X, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, EndBoard)
  ;
  false
  ).

attackDown(Board, _, _, Board).

% ATTACK UPLEFT

attackUpLeft(Board, X, Y, EndBoard):-
  X1 is X - 1,
  Y1 is Y - 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackUpLeft(Board, _, _, Board).

% ATTACK DOWNLEFT

attackDownLeft(Board, X, Y, EndBoard):-
  X1 is X - 1,
  Y1 is Y + 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackDownLeft(Board, _, _, Board).

% ATTACK DOWNRIGHT

attackDownRight(Board, X, Y, EndBoard):-
  X1 is X + 1,
  Y1 is Y + 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackDownRight(Board, _, _, Board).

% ATTACK UPRIGHT

attackUpRight(Board, X, Y, EndBoard):-
  X1 is X + 1,
  Y1 is Y - 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, EndBoard)
  ;
  false
  ).

attackUpRight(Board, _, _, Board).


% ATTACK LINE

attackRow(Board, X, Y, EndBoard):-
  attackRowNeg(Board, X, Y, NewBoard),
  attackRowPos(NewBoard, X, Y, EndBoard).

attackRowNeg(Board, 0, _, Board).

attackRowNeg(Board, X, Y, EndBoard):-
  X1 is X-1,
  (
  getMatrixAt(Y, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, NewBoard),!,
  attackRowNeg(NewBoard, X1, Y, EndBoard)
  ;
  false
  ).

attackRowNeg(Board, _, _, Board).

attackRowPos(Board, 7, _, Board).

attackRowPos(Board, X, Y, EndBoard):-
  X1 is X + 1,
  (
  getMatrixAt(Y, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y, X1, NewCell, NewBoard),!,
  attackRowPos(NewBoard, X1, Y, EndBoard)
  ;
  false
  ).

attackRowPos(Board, _, _, Board).

% ATTACK COLUMN

attackColumn(Board, X, Y, EndBoard):-
  attackColumnNeg(Board, X, Y, NewBoard),
  attackColumnPos(NewBoard, X, Y, EndBoard).

attackColumnNeg(Board, _, 0, Board).

attackColumnNeg(Board, X, Y, EndBoard):-
  Y1 is Y-1,
  (
  getMatrixAt(Y1, X, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, NewBoard),!,
  attackColumnNeg(NewBoard, X, Y1, EndBoard)
  ;
  false
  ).

attackColumnPos(Board, _, 7, Board).

attackColumnPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  (
  getMatrixAt(Y1, X, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X, NewCell, NewBoard),!,
  attackColumnPos(NewBoard, X, Y1, EndBoard)
  ;
  false
  ).


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
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),
  attackDiagonalLeftPos(NewBoard, X1, Y1, EndBoard)
  ;
  false
  ).

attackDiagonalRightPos(Board, _, 7, Board).
attackDiagonalRightPos(Board, 7, _, Board).

attackDiagonalRightPos(Board, X, Y, EndBoard):-
  Y1 is Y + 1,
  X1 is X + 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),
  attackDiagonalRightPos(NewBoard, X1, Y1, EndBoard)
  ;
  false
  ).

attackDiagonalLeftNeg(Board, _, 0, Board).
attackDiagonalLeftNeg(Board, 0, _, Board).

attackDiagonalLeftNeg(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  X1 is X - 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),
  attackDiagonalLeftNeg(NewBoard, X1, Y1, EndBoard)
  ;
  false
  ).

attackDiagonalRightNeg(Board, _, 0, Board).
attackDiagonalRightNeg(Board, 7, _, Board).

attackDiagonalRightNeg(Board, X, Y, EndBoard):-
  Y1 is Y - 1,
  X1 is X + 1,
  (
  getMatrixAt(Y1, X1, Board, Cell),
  member(Cell, [0,1,2,3,4,5,6,7]),
  NewCell is Cell + 1,
  replace(Board, Y1, X1, NewCell, NewBoard),
  attackDiagonalRightNeg(NewBoard, X1, Y1, EndBoard)
  ;
  false
  ).

attackDiagonalRightNeg(Board, _, _, Board).




row(N, Matrix, Row):-
  nth0(N, Matrix, Row).

col(N, Matrix, Col):-
  maplist(nth0(N), Matrix, Col).
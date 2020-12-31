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

attackColumnNeg(Board, _, _, Board).



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

attackColumnPos(Board, _, _, Board).


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

attackDiagonalLeftPos(Board, _, _, Board).



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

attackDiagonalRightPos(Board, _, _, Board).



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

attackDiagonalLeftNeg(Board, _, _, Board).



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
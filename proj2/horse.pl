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
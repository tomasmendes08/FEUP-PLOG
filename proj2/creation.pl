


placeAttacks(Board):-
    placePiece(Board, NextBoard),
    rookAttack(NextBoard, 3, 0, Board1),
    bishopAttack(Board1, 2, 5, Board2),
    kingAttack(Board2, 7, 1, Board3),
    queenAttack(Board3, 0, 1, Board4),
    knightAttack(Board4, 6, 3, Board5),
    pawnAttack(Board5, 5, 4, EndBoard),
    printBoard(EndBoard).


placePiece(Board, EndBoard):-
  replace(Board, 1, 0, 'Q', Board1),
  replace(Board1, 0, 3, 'R', Board2),
  replace(Board2, 4, 5, 'P', Board3),
  replace(Board3, 1, 7, 'K', Board4),
  replace(Board4, 5, 2, 'B', Board5),
  replace(Board5, 3, 6, 'H', EndBoard),
  printBoard(EndBoard).



% GET THE CELL AT CERTAIN COORDINATES

getMatrixAt(Row, Col, Matrix, Cell):-
  nth0(Row, Matrix, MatrixRow),
  nth0(Col, MatrixRow, Cell).


% REPLACE CELL WITH PIECE

replace( [L|Ls] , 0 , Y , Piece , [R|Ls] ) :-   % once we find the desired row, (Está a fazer Y,X)
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
  attackDiagonal(Board2, X, Y, EndBoard).
  %replace(Board3, Y, X, 'Q', EndBoard).

% ADDS ROOK ATTACKS

rookAttack(Board, X, Y, EndBoard):-
  attackRow(Board, X, Y, Board1),
  attackColumn(Board1, X, Y, EndBoard).
  %replace(Board2, Y, X, 'R', EndBoard).

% ADDS BISHOP ATTACKS

bishopAttack(Board, X, Y, EndBoard):-
  attackDiagonal(Board, X, Y, EndBoard).
  %replace(Board1, Y, X, 'B', EndBoard).

% ADDS KING ATTACKS

kingAttack(Board, X, Y, EndBoard):-
  attackLeft(Board, X, Y, Board1),
  attackRight(Board1, X, Y, Board2),
  attackUp(Board2, X, Y, Board3),
  attackDown(Board3, X, Y, Board4),
  attackUpLeft(Board4, X, Y, Board5),
  attackUpRight(Board5, X, Y, Board6),
  attackDownLeft(Board6, X, Y, Board7),
  attackDownRight(Board7, X, Y, EndBoard).
  %replace(Board8, Y, X, 'K', EndBoard).

% ADDS PAWN ATTACKS

pawnAttack(Board, X, Y, EndBoard):-
  attackUpRight(Board, X, Y, Board1),
  attackUpLeft(Board1, X, Y, EndBoard).
  %replace(Board2, Y, X, 'P', EndBoard).

% ADDS KNIGHT ATTACKS

knightAttack(Board, X, Y, EndBoard):-
  attackKnightUpLeft(Board, X, Y, Board1),
  attackKnightUpRight(Board1, X, Y, Board2),
  attackKnightLeftUp(Board2, X, Y, Board3),
  attackKnightLeftDown(Board3, X, Y, Board4),
  attackKnightRightUp(Board4, X, Y, Board5),
  attackKnightRightDown(Board5, X, Y, Board6),
  attackKnightDownLeft(Board6, X, Y, Board7),
  attackKnightDownRight(Board7, X, Y, EndBoard).
  %replace(Board8, Y, X, 'H', EndBoard).


row(N, Matrix, Row):-
  nth0(N, Matrix, Row).

col(N, Matrix, Col):-
  maplist(nth0(N), Matrix, Col).
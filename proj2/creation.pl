


placeAttacks(Board):-
    placePiece(Board, NextBoard),
    printBoard(NextBoard).
    


placePiece(Board, EndBoard):-
  (
  tryPlacingPiece(Board, EndBoard)
  ;
  placePiece(Board, EndBoard)
  ).


tryPlacingPiece(Board, EndBoard):-
  random(0, 7, Qx), random(0, 7, Qy), random(0, 7, Rx), random(0, 7, Ry),
  random(0, 7, Px), random(0, 7, Py), random(0, 7, Kx), random(0, 7, Ky),
  random(0, 7, Bx), random(0, 7, By), random(0, 7, Hx), random(0, 7, Hy),
  unique([[Qx, Qy], [Rx, Ry], [Px, Py], [Kx, Ky], [Bx, By], [Hx, Hy]]),
  replace(Board, Qy, Qx, 'Q', Board1),
  replace(Board1, Ry, Rx, 'R', Board2),
  replace(Board2, Py, Px, 'P', Board3),
  replace(Board3, Ky, Kx, 'K', Board4),
  replace(Board4, By, Bx, 'B', Board5),
  replace(Board5, Hy, Hx, 'H', Board6),
  rookAttack(Board6, Rx, Ry, Board7),
  bishopAttack(Board7, Bx, By, Board8),
  kingAttack(Board8, Kx, Ky, Board9),
  queenAttack(Board9, Qx, Qy, Board10),
  knightAttack(Board10, Hx, Hy, Board11),
  pawnAttack(Board11, Px, Py, EndBoard),
  %printBoard(EndBoard),
  testBoard1(Input),!,
  checkOver(EndBoard, Input),
  printBoard(EndBoard).



% CHECK IF THE BOARD IS CORRET

checkOver(_, []).

checkOver(Board, [[A, B, C]|Tail]):-
  %write(A),
  %write(B),
  %write(C),nl,
  getMatrixAt(B, A, Board, Cell),!,
  member(Cell, [0,1,2,3,4,5,6,7]),
  C =:= Cell,
  checkOver(Board, Tail).


% CHECK IF NO PIECES ARE ON TOP OF EACH OTHER

unique([]).
unique([X|Xs]) :- \+ member(X, Xs), unique(Xs).


% GET THE CELL AT CERTAIN COORDINATES

getMatrixAt(Row, Col, Matrix, Cell):-
  nth0(Row, Matrix, MatrixRow),
  nth0(Col, MatrixRow, Cell).


% REPLACE CELL WITH PIECE

replace( [L|Ls] , 0 , Y , Piece , [R|Ls] ) :-   % once we find the desired row, (Está a fazer Y,X)
  replace_column(L,Y,Piece,R).                  % - we replace specified column, and we're done.


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
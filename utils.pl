
checkPlayer(L, black):- nth0(0, L, black).
checkPlayer(L, white):- nth0(0, L, white).
checkPlayer(L, _):- fail.


checkPiece(Content):- Content \= [empty,0].

checkEmptyContent(Content):- Content == [empty,0].


getMatrixAt(0, Column, [HeaderLines|_], Number):-
	getLineAt(Column, HeaderLines, Number).


getMatrixAt(Line, Column, [_|TailLines], Number):-
	Line > 0,
	NewLine is Line-1,
	getMatrixAt(NewLine, Column, TailLines, Number).
  

getLineAt(0, [HeaderNumbers|_], HeaderNumbers).

getLineAt(Index, [_|TailNumbers], Number):-
	Index > 0,
	NewIndex is Index-1,
	getLineAt(NewIndex, TailNumbers, Number).
  


replaceCell([L|Ls] , 0 , Y , Z , [R|Ls]) :- 
  replace_column(L,Y,Z,R).              

replaceCell( [L|Ls] , X , Y , Z , [L|Rs] ) :- 
  X > 0 ,                                
  X1 is X-1 ,                             
  replaceCell( Ls , X1 , Y , Z , Rs ).    

replace_column([C|Cs] , 0 , Z , [Ln|Cs]):-  
  append(Z, C, Ln).
replace_column([C|Cs] , Y , Z , [C|Rs]) :- 
  Y > 0 ,                                 
  Y1 is Y-1 ,                             
  replace_column( Cs , Y1 , Z , Rs ). 



replaceEmpty([L|Ls] , 0 , Y , Z , [R|Ls]) :-
  replace_columnempty(L,Y,Z,R).
replaceEmpty( [L|Ls] , X , Y , Z , [L|Rs] ) :-
  X > 0 ,                                 
  X1 is X-1 ,                             
  replaceEmpty( Ls , X1 , Y , Z , Rs ).    

replace_columnempty([_|Cs] , 0 , Z , [Z|Cs]).
replace_columnempty([C|Cs] , Y , Z , [C|Rs]) :- 
  Y > 0 ,                                  
  Y1 is Y-1 ,                              
  replace_columnempty( Cs , Y1 , Z , Rs ).      


countGreen([], _, Counter, NewCounter):-
    %write(Counter),nl,
    NewCounter = Counter.

countGreen([H|T], H, OldCounter, NewCounter):-
    NewCounter2 is OldCounter+1,
    countGreen(T, H, NewCounter2, NewCounter).

countGreen([_|T], H2, Counter, NewCounter):-
    countGreen(T, H2, Counter, NewCounter).


iterateBoard([], Player, _Points, _NewPoints, _PreviousIterationCounter, NewPreviousIterCounter):-
  format('\n~w points = ~w\n',[Player,NewPreviousIterCounter]).


iterateBoard([H|T], Player, Points, NewPoints, PreviousIterationCounter, NewPreviousIterCounter):-
  lineFound(H, Player, Points, NewPoints, PreviousIterationCounter, FinalCounter),
  %nl,write(FinalCounter),nl,
  AuxNewPreviousIterCounter is FinalCounter + NewPreviousIterCounter,
  %nl,write(AuxNewPreviousIterCounter),nl,
  iterateBoard(T, Player, 0, _AuxPoints, PreviousIterationCounter, AuxNewPreviousIterCounter).


lineFound([], _, _Points, _NewPoints, NewPreviousIterCounter, FinalCounter):- 
  FinalCounter = NewPreviousIterCounter.

lineFound([H|T], Player, Points, NewPoints, PreviousIterationCounter, FinalCounter):-
  countAllPoints(H, Player, Points, NewPoints),
  NewPreviousIterCounter is PreviousIterationCounter + NewPoints,
  lineFound(T, Player, 0, _AuxCounter, NewPreviousIterCounter, FinalCounter).


countAllPoints([H|T], Player, Counter, NewCounter):-
  (
    checkPlayer([H|T], Player) -> countGreen([H|T], green, Counter, NewCounter); %nl,write(NewCounter),nl;
    NewCounter is 0
  ).


validateFirstPiece(GameState, Player, Row, Col):-
  getMatrixAt(Row, Col, GameState, Content),
  checkPlayer(Content, Player).



%CHECK IF MOVE IS POSSIBLE


checkMoves(GameState, Player, SelectCol, SelectRow, MoveCol, MoveRow, _ConfirmedCol, _ConfirmedRow):-
  getMatrixAt(MoveRow, MoveCol, GameState, MoveContent),
  %write(MoveContent),nl,
  checkPiece(MoveContent),
  SelectCol =:= MoveCol,
  (
    SelectRow < MoveRow -> AuxRow is MoveRow - SelectRow, AuxRow < 6, checkDownPieces(GameState, Player, MoveCol, MoveRow, AuxRow);
    AuxRow is SelectRow - MoveRow, AuxRow < 6, checkUpPieces(GameState, Player, MoveCol, MoveRow, AuxRow)
  );
  getMatrixAt(MoveRow, MoveCol, GameState, MoveContent),
  %write(MoveContent),nl,
  checkPiece(MoveContent),
  SelectRow =:= MoveRow,
  (
    SelectCol < MoveCol -> AuxCol is MoveCol - SelectCol, AuxCol < 6, checkRightPieces(GameState, Player, MoveCol, MoveRow, AuxCol);
    AuxCol is SelectCol - MoveCol, AuxCol < 6, checkLeftPieces(GameState, Player, MoveCol, MoveRow, AuxCol) 
  ).


checkLeftPieces(_GameState, _Player, _MoveCol, _MoveRow, 1).

checkLeftPieces(GameState, Player, MoveCol, MoveRow, AuxCol):-
  Aux is MoveCol + 1,
  getMatrixAt(MoveRow, Aux, GameState, Content),
  %write(Content),nl,
  checkEmptyContent(Content),  %se na casa da direita estiver uma peça, falha
  Aux2 is AuxCol - 1, 
  checkLeftPieces(GameState, Player, Aux, MoveRow, Aux2).


checkRightPieces(_GameState, _Player, _MoveCol, _MoveRow, 1).

checkRightPieces(GameState, Player, MoveCol, MoveRow, AuxCol):-
  Aux is MoveCol - 1,
  getMatrixAt(MoveRow, Aux, GameState, Content),
  %write(Content),nl,
  checkEmptyContent(Content),  %se na casa da esquerda estiver uma peça, falha
  Aux2 is AuxCol - 1, 
  checkRightPieces(GameState, Player, Aux, MoveRow, Aux2).


checkUpPieces(_GameState, _Player, _MoveCol, _MoveRow, 1).

checkUpPieces(GameState, Player, MoveCol, MoveRow, AuxRow):-
  Aux is MoveRow + 1,
  getMatrixAt(Aux, MoveCol, GameState, Content),
  %write(Content),nl,
  checkEmptyContent(Content),  %se na casa abaixo estiver uma peça, falha
  Aux2 is AuxRow - 1, 
  checkUpPieces(GameState, Player, MoveCol, Aux, Aux2).
  

checkDownPieces(_GameState, _Player, _MoveCol, _MoveRow, 1).

checkDownPieces(GameState, Player, MoveCol, MoveRow, AuxRow):-
  Aux is MoveRow - 1,
  getMatrixAt(Aux, MoveCol, GameState, Content),
  %write(Content),nl,
  checkEmptyContent(Content),  %se na casa acima estiver uma peça, falha
  Aux2 is AuxRow - 1, 
  checkDownPieces(GameState, Player, MoveCol, Aux, Aux2).



% CHECK IF THERE'S ANY MOVE LEFT TO MAKE


checkMovesLeft(_GameState, _Player):- fail.


% RIGHT SIDE

contentRightFound(Col, Row, Player, GameState):-
  Row < 6,
  Col < 5,
  getMatrixAt(Row, Col, GameState, CellContent),
  write(CellContent),nl,
  checkPlayer(CellContent, Player),
  AuxCol is Col + 1,
  contentRightFoundAux(AuxCol, Row, Player, GameState).

contentRightFound(Col, Row, Player, GameState):-
  Row < 6,
  Col < 5,
  AuxCol2 is Col + 1,
  write(Col),nl,
  contentRightFound(AuxCol2, Row, Player, GameState).

contentRightFound(Col, Row, Player, GameState):-
  Row < 6,
  Col >= 5,
  AuxRow is Row + 1,
  write(Col),nl,
  contentRightFound(0, AuxRow, Player, GameState).


contentRightFoundAux(Col, Row, _Player, GameState):-
  Col < 6,
  getMatrixAt(Row, Col, GameState, ContentRight),
  write(ContentRight),nl,
  checkPiece(ContentRight).

contentRightFoundAux(Col, Row, Player, GameState):-
  Col < 6,
  AuxCol is Col + 1,
  contentRightFoundAux(AuxCol, Row, Player, GameState).

  
% LEFT SIDE

contentLeftFound(Col, Row, Player, GameState):-
  Row < 6,
  Col < 5,
  getMatrixAt(Row, Col, GameState, CellContent),
  %write(CellContent),nl,
  checkPlayer(CellContent, Player),
  AuxCol is Col - 1,
  contentLeftFoundAux(AuxCol, Row, Player, GameState).

contentLeftFound(Col, Row, Player, GameState):-
  Row < 6,
  Col < 5,
  AuxCol2 is Col + 1,
  %write(Col),nl,
  contentLeftFound(AuxCol2, Row, Player, GameState).

contentLeftFound(Col, Row, Player, GameState):-
  Row < 6,
  Col >= 5,
  AuxRow is Row + 1,
  %write(Col),nl,
  contentLeftFound(0, AuxRow, Player, GameState).


contentLeftFoundAux(Col, Row, _Player, GameState):-
  Row < 6,
  Col > -1,
  getMatrixAt(Row, Col, GameState, ContentLeft),
  %write(ContentLeft),nl,
  checkPiece(ContentLeft).

contentLeftFoundAux(Col, Row, Player, GameState):-
  Row < 6,
  Col > -1,
  AuxCol is Col - 1,
  contentLeftFoundAux(AuxCol, Row, Player, GameState).



% DOWN SIDE


contentDownFound(Col, Row, Player, GameState):-
  Row < 5,
  Col < 6,
  getMatrixAt(Row, Col, GameState, CellContent),
  write(CellContent),nl,
  checkPlayer(CellContent, Player),
  AuxRow is Row + 1,
  contentDownFoundAux(Col, AuxRow, Player, GameState).

contentDownFound(Col, Row, Player, GameState):-
  Row < 5,
  Col < 6,
  AuxRow2 is Row + 1,
  write(Row),nl,
  contentDownFound(Col, AuxRow2, Player, GameState).

contentDownFound(Col, Row, Player, GameState):-
  Row >= 5,
  Col < 6,
  AuxCol is Col + 1,
  write(Row),nl,
  contentDownFound(AuxCol, 0, Player, GameState).


contentDownFoundAux(Col, Row, _Player, GameState):-
  Row < 6,
  getMatrixAt(Row, Col, GameState, ContentDown),
  write(ContentDown),nl,
  checkPiece(ContentDown).

contentDownFoundAux(Col, Row, Player, GameState):-
  Row < 6,
  AuxRow is Row + 1,
  contentDownFoundAux(Col, AuxRow, Player, GameState).



% UP SIDE


contentUpFound(Col, Row, Player, GameState):-
  Row < 5,
  Col < 6,
  getMatrixAt(Row, Col, GameState, CellContent),
  write(CellContent),nl,
  checkPlayer(CellContent, Player),
  AuxRow is Row - 1,
  contentUpFoundAux(Col, AuxRow, Player, GameState).

contentUpFound(Col, Row, Player, GameState):-
  Row < 5,
  Col < 6,
  AuxRow2 is Row + 1,
  write(Row),nl,
  contentUpFound(Col, AuxRow2, Player, GameState).

contentUpFound(Col, Row, Player, GameState):-
  Row >= 5,
  Col < 6,
  AuxCol is Col + 1,
  write(Row),nl,
  contentUpFound(AuxCol, 0, Player, GameState).


contentUpFoundAux(Col, Row, _Player, GameState):-
  Row > -1,
  getMatrixAt(Row, Col, GameState, ContentUp),
  write(ContentUp),nl,
  checkPiece(ContentUp).

contentUpFoundAux(Col, Row, Player, GameState):-
  Row > -1,
  AuxRow is Row - 1,
  contentUpFoundAux(Col, AuxRow, Player, GameState).


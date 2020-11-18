
checkPlayer(L, black):- nth0(0, L, black).
checkPlayer(L, white):- nth0(0, L, white).
checkPlayer(L, _):- fail.

checkPiece(Content):- Content \= [empty,0].

getCell(SelectCol, SelectRow, Content, GameState):-
    nth0(SelectRow, GameState, Row),
    nth0(SelectCol, Row, Content),
    format('\nPiece: ~d ~d\nContent: ', [SelectCol, SelectRow]),
    write(Content),
    nl.



getMatrixAt(0, Column, [HeaderLines|_], Number):-
	getLineAt(Column, HeaderLines, Number).


getMatrixAt(Line, Column, [_|TailLines], Number):-
  %write('\n1\n'),
	Line > 0,
	NewLine is Line-1,
	getMatrixAt(NewLine, Column, TailLines, Number).
  

getLineAt(0, [HeaderNumbers|_], HeaderNumbers).

getLineAt(Index, [_|TailNumbers], Number):-
  %write('\n2\n'),
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
    NewCounter = Counter.

countGreen([H|T], H, OldCounter, NewCounter):-
    NewCounter2 is OldCounter+1,
    countGreen(T, H, NewCounter2, NewCounter).

countGreen([_|T], H2, Counter, NewCounter):-
    countGreen(T, H2, Counter, NewCounter).


iterateBoard([], Player, Points, NewPoints, PreviousIterationCounter, NewPreviousIterCounter):-
  nl,
  write(Player),
  write(' points = '),
  write(NewPreviousIterCounter), nl.
iterateBoard([H|T], Player, Points, NewPoints, PreviousIterationCounter, NewPreviousIterCounter):-
  lineFound(H, Player, Points, NewPoints, PreviousIterationCounter, FinalCounter),
  %nl,write(FinalCounter),nl,
  AuxNewPreviousIterCounter is FinalCounter + NewPreviousIterCounter,
  %nl,write(AuxNewPreviousIterCounter),nl,
  iterateBoard(T, Player, 0, AuxPoints, PreviousIterationCounter, AuxNewPreviousIterCounter).


lineFound([], _, Points, NewPoints, NewPreviousIterCounter, FinalCounter):- 
  FinalCounter = NewPreviousIterCounter.

lineFound([H|T], Player, Points, NewPoints, PreviousIterationCounter, FinalCounter):-
  countAllPoints(H, Player, Points, NewPoints),
  NewPreviousIterCounter is PreviousIterationCounter + NewPoints,
  lineFound(T, Player, 0, AuxCounter, NewPreviousIterCounter, FinalCounter).


countAllPoints([H|T], Player, Counter, NewCounter):-
  (
    checkPlayer([H|T], Player) -> countGreen([H|T], green, Counter, NewCounter);
    NewCounter is 0
  ).


validatePiece(GameState, Player, SelectCol, SelectRow):-
  getMatrixAt(SelectRow, SelectCol, GameState, Content),
  (
    checkPlayer(Content, Player);
    (
      nl, write('Must choose a '), write(Player), write(' piece!\n'),
      movePiece(GameState, NewSelectCol, NewSelectRow, NewContent, MoveDoneGameState, Player)
    )
  ).


validateMove(GameState, Player, SelectCol, SelectRow, MoveCol, MoveRow):-
  validatePiece(GameState, Player, SelectCol, SelectRow).
  
checkPossibleMove(GameState, Player, SelectCol, SelectRow, MoveCol, MoveRow):-
  getMatrixAt(MoveRow, MoveCol, GameState, Content),
  checkPiece(Content).



/*
validateContent(SelectCol, SelectRow, Player, Content, GameState, MoveDoneGameState):-
    getCell(SelectCol, SelectRow, Content, GameState),
    (
        checkPlayer(Content, Player);
        (
            write('\nInvalid piece. Choose again\n'),
            movePiece(GameState, Player)
        )
    ).

validateMove(MoveCol, MoveRow, SelectCol, SelectRow, GameState, Player, Content, MoveDoneGameState):-
    getCell(MoveCol, MoveRow, SelectCol, NewContent, GameState),
    (
        checkPiece(NewContent),
        replaceEmpty(GameState, SelectRow, SelectCol, ['empty'], NewGameState),
        replaceCell(NewGameState, MoveRow, MoveCol, Content, MoveDoneGameState);
        (
            write('\nMove not valid. Insert move again\n'),
            movePiece(GameState, Player, MoveDoneGameState)
        )
    ).*/


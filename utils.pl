checkPlayer(L, 'B'):- nth0(0, L, black).
checkPlayer(L, 'W'):- nth0(0, L, white).

checkPiece(Content):- Content \= [empty].

getCell(SelectCol, SelectRow, Content, GameState):-
    nth0(SelectRow, GameState, Row),
    nth0(SelectCol, Row, Content),
    format('\nPiece: ~d ~d\nContent: ', [SelectCol, SelectRow]),
    write(Content),
    nl.

/*replaceCell([L|Ls] , 0 , Y , Z , [R|Ls]) :- 
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


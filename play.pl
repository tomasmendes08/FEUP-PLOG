play:-
    initial(GameState),
    display_game(GameState),
    gameLoop(GameState).

initial(GameState):-
    initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).


gameLoop(GameState):-
    %white
    movePiece(GameState, SelectCol, SelectRow, Content, AfterWhiteMove, 'white'),
    printBoard(AfterWhiteMove),
    %check if game is over

    %black
    movePiece(AfterWhiteMove, SelectCol, SelectRow, Content, AfterBlackMove, 'black'),
    printBoard(AfterBlackMove),
    %check if game is over
    gameLoop(AfterBlackMove).
    

endGame:-
    write('Black wins !!!\n Game Over.\n'). 

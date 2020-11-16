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
    movePiece(GameState, SelectColW, SelectRowW, ContentW, AfterWhiteMove, 'white'),
    printBoard(AfterWhiteMove),
    %check if game is over

    %black
    movePiece(AfterWhiteMove, SelectColB, SelectRowB, ContentB, AfterBlackMove, 'black'),
    printBoard(AfterBlackMove),
    %check if game is over
    gameLoop(AfterBlackMove).
    

endGame:-
    write('Black wins !!!\n Game Over.\n'). 

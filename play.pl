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
    movePiece(GameState, SelectColW, SelectRowW, ContentW, AfterWhiteMove, white),
    nl,
    printBoard(AfterWhiteMove),
    IterationCounter is 0,
    NewIterationCounter is 0,
    iterateBoard(AfterWhiteMove, white, Points, NewPoints, IterationCounter, NewIterationCounter),
    IterationCounter is 0,
    NewIterationCounter is 0,
    iterateBoard(AfterWhiteMove, black, Points, NewPoints, IterationCounter, NewIterationCounter),
    %check if game is over

    %black
    movePiece(AfterWhiteMove, SelectColB, SelectRowB, ContentB, AfterBlackMove, black),
    printBoard(AfterBlackMove),
    IterationCounter is 0,
    NewIterationCounter is 0,
    iterateBoard(AfterBlackMove, white, Points, NewPoints, IterationCounter, NewIterationCounter),
    IterationCounter is 0,
    NewIterationCounter is 0,
    iterateBoard(AfterBlackMove, black, Points, NewPoints, IterationCounter, NewIterationCounter),
    %check if game is over
    gameLoop(AfterBlackMove).
    

endGame:-
    write('Black wins !!!\n Game Over.\n'). 

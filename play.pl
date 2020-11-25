play:-
    initial(GameState),
    display_game(GameState),
    gameLoop(GameState).

initial(GameState):-
    endgameBoard(GameState).
    %initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).


gameLoop(GameState):-
    %white
    /*Row is 0,    
    checkIfExistsMoves(GameState, white, Row),
    */
    write('\naqui\n'),
    Col is 0, 
    Row is 0,!,
    contentLeftFound(Col, Row, white, GameState),
    write('\naqui2\n'), 
    choosePiece(GameState, SelectColW, SelectRowW, AfterWhiteMove, white),
    nl,
    printBoard(AfterWhiteMove),
    IterationCounter is 0,
    NewIterationCounter is 0,
    iterateBoard(AfterWhiteMove, white, Points, NewPoints, IterationCounter, NewIterationCounter),
    IterationCounter is 0,
    NewIterationCounter is 0,
    iterateBoard(AfterWhiteMove, black, Points, NewPoints, IterationCounter, NewIterationCounter), %count players points 
    %check if game is over

    %black
    choosePiece(AfterWhiteMove, SelectColB, SelectRowB, AfterBlackMove, black),
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

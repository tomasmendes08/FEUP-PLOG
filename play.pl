play:-
    initial(GameState),
    display_game(GameState),
    gameLoop(GameState).

initial(GameState):-
    midgameBoard(GameState).
    %initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).


gameLoop(GameState):-
    %white
    /*Row is 0,    
    checkIfExistsMoves(GameState, white, Row),
    */
    Col is 0, 
    Row is 0,
    (
        (
        contentAnyFound(Col, Row, white, GameState),
        choosePiece(GameState, _SelectColW, _SelectRowW, AfterWhiteMove, white),
        printBoard(AfterWhiteMove),
        iteration(AfterWhiteMove, Points, NewPoints),
        NextGameState = AfterWhiteMove
        )
        ;
        (
        Check1 is 1,
        printBoard(GameState),
        iteration(GameState, Points, NewPoints),
        NextGameState = GameState
        )
    ),
    nl, %count players points 

    %black
    (
        (
        contentAnyFound(Col, Row, black, NextGameState),
        choosePiece(NextGameState, _SelectColB, _SelectRowB, AfterBlackMove, black),
        printBoard(AfterBlackMove),
        iteration(AfterBlackMove, Points, NewPoints),!,
        gameLoop(AfterBlackMove)
        )
        ;
        (
        (
        \+checkGameOver(Check1),
        printBoard(NextGameState),
        iteration(NextGameState, Points, NewPoints),!,
        gameLoop(NextGameState)
        )
        ;
        gameOver
        )
    ).

iteration(GameState, Points, NewPoints):-
        IterationCounter is 0,
        NewIterationCounter is 0,
        iterateBoard(GameState, white, Points, NewPoints, IterationCounter, NewIterationCounter),
        IterationCounter is 0,
        NewIterationCounter is 0,
        iterateBoard(GameState, black, Points, NewPoints, IterationCounter, NewIterationCounter).

checkGameOver(Check1):-
    Check1 == 1.


gameOver:-
    write('GAME OVER!!!!!\n').

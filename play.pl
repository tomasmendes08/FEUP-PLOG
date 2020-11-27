start:-
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
        %valid_moves(GameState, white, _),
        contentAnyFound(Col, Row, white, GameState),
        choosePiece(GameState, _SelectColW, _SelectRowW, AfterWhiteMove, white),
        printBoard(AfterWhiteMove),
        iterationPrint(AfterWhiteMove),
        NextGameState = AfterWhiteMove
        )
        ;
        (
        Check1 is 1,
        printBoard(GameState),
        iterationPrint(GameState),
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
        iterationPrint(AfterBlackMove),!,
        gameLoop(AfterBlackMove)
        )
        ;
        (
        (
        \+checkGameOver(Check1),
        printBoard(NextGameState),
        iterationPrint(NextGameState),!,
        gameLoop(NextGameState)
        )
        ;
        gameOver
        )
    ).


gameOver:-
    write('GAME OVER!!!!!\n').

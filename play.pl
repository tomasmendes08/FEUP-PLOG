start:-
    initial(GameState),
    display_game(GameState),
    gameLoop(GameState).

startPvsBot:-
    initial(GameState),
    display_game(GameState),
    gameLoopPvBot(GameState).

initial(GameState):-
    endgameBoard(GameState).
    %midgameBoard(GameState).
    %initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).


gameLoopPvBot(GameState):-
    Col is 0, 
    Row is 0,
    (
        (
        contentAnyFound(Col, Row, white, GameState),
        choose_move(GameState, white, Level, Move),
        write(Move),nl,
        nth0(0, Move, SelectCol),
        nth0(1, Move, SelectRow),
        nth0(2, Move, MoveCol),
        nth0(3, Move, MoveRow),
        movePiece(GameState, SelectCol, SelectRow, MoveCol, MoveRow, AfterWhiteMove),
        write(AfterWhiteMove),nl,
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
        gameLoopPvBot(AfterBlackMove)
        )
        ;
        (
        (
        \+checkGameOver(Check1),
        printBoard(NextGameState),
        iterationPrint(NextGameState),!,
        gameLoopPvBot(NextGameState)
        )
        ;
        gameOver
        )
    ).


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
        write(AfterWhiteMove),nl,
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

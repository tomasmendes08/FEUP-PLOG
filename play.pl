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
    Check = 0,
    Col is 0, 
    Row is 0,
    (
        (
        contentAnyFound(Col, Row, white, GameState),
        choosePiece(GameState, _SelectColW, _SelectRowW, AfterWhiteMove, white),
        printBoard(AfterWhiteMove),
        iteration(AfterWhiteMove, Points, NewPoints)
        )
        ;
        (
        Check1 is 1,
        printBoard(GameState),
        iteration(AfterWhiteMove, Points, NewPoints)
        )
    ),
    nl, %count players points 

    %black
    (
        (
        contentAnyFound(Col, Row, black, GameState),
        choosePiece(AfterWhiteMove, _SelectColB, _SelectRowB, AfterBlackMove, black),
        printBoard(AfterBlackMove),
        iteration(GameState, Points, NewPoints),
        gameLoop(AfterBlackMove)
        )
        ;
        (
        \+func(Check1),
        printBoard(AfterWhiteMove),
        iteration(GameState, Points, NewPoints),
        gameLoop(AfterWhiteMove)
        )
    ).

iteration(GameState, Points, NewPoints):-
        IterationCounter is 0,
        NewIterationCounter is 0,
        iterateBoard(GameState, white, Points, NewPoints, IterationCounter, NewIterationCounter),
        IterationCounter is 0,
        NewIterationCounter is 0,
        iterateBoard(GameState, black, Points, NewPoints, IterationCounter, NewIterationCounter).

func(Check1):-
    Check1 == 1.

endGame:-
    write('Black wins !!!\n Game Over.\n'). 

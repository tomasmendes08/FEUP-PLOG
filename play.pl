play:-
    initial(GameState),
    display_game(GameState),
    gameLoop(Player1, Player2, GameState).

initial(GameState):-
    initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).

repeat.
repeat:-
    repeat.

gameLoop(Player1, Player2, GameState):-
    initial(GameState),
    assert(state(Player1, GameState)),
    repeat,
        retract(state(Player, GameState)),
        once(movePiece(GameState, SelectCol, SelectRow, Content, Player, MoveDoneGameState, NextPlayer)),
        once(printBoard(MoveDoneGameState)),
        assert(state(NextPlayer, MoveDoneGameState)),
        fail.

endGame:-
    write('Black wins !!!\n Game Over.\n'). 

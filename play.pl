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
        write('\naqui1\n'),
        retract(state(Player1, GameState)),
        write('\naqui2\n'),
        once(movePiece(GameState, SelectCol, SelectRow, Content, Player1, MoveDoneGameState, Player2)),
        assert(state(Player2, MoveDoneGameState)),
        write('\naqui3\n'),
        once(printBoard(MoveDoneGameState)),
        write('\naqui4\n'),
        fail.

endGame:-
    write('Black wins !!!\n Game Over.\n'). 

play:-
    initial(GameState),
    display_game(GameState).
    %gameLoop(Player1, Player2, GameState).

initial(GameState):-
    initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).

/*repeat.
repeat:-repeat.

gameLoop(Player1, Player2, GameState):-
    initial(Board).
    assert(move(1, Player1)),
    assert(move(2, Player2)),
    assert(state(1, Board)),
    repeat,
        retract(state(Player, Board)),
        once(movePiece(GameState, SelectCol, SelectRow, Content, Player, MoveDoneGameState)),
        assert(state(NextPlayer, MoveDoneGameState)).
    endGame.

endGame:-
    write('Black wins !!!\n Game Over.\n'). */

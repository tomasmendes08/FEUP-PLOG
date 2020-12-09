play:-
    initial(GameState),
    display_game(GameState).

initial(GameState):-
    initialBoard(GameState).

display_game(GameState):-
    printBoard(GameState).


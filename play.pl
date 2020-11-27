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


iterationPrint(NextGameState):-
    iterateBoard(NextGameState, white, WhitePoints),
    format('\n~w points  = ~w\n', [white, WhitePoints]),
    iterateBoard(NextGameState, black, BlackPoints),
    format('\n~w points  = ~w\n', [black, BlackPoints]).


iterateBoard([], _, 0).

iterateBoard([H|T],Player, BoardPoints):-
    iterateLine(H, Player, LinePoints),
    iterateBoard(T, Player, TailPoints),
    BoardPoints is LinePoints + TailPoints.

iterateLine([], _, 0).

iterateLine([H|T], Player, LinePoints):-
    iterateCell(H, Player, CellPoints),
    iterateLine(T, Player, TailLinePoints),
    LinePoints is CellPoints + TailLinePoints.

iterateCell([], _, 0).

iterateCell(Cell, Player, Points):-
    (
    checkPlayer(Cell, Player),
    count(green, Cell, Points)
    ;
    Points is 0
    ).



count(_, [], 0).
count(X, [X | T], N) :-
  !, count(X, T, N1),
  N is N1 + 1.
count(X, [_ | T], N) :-
  count(X, T, N).

checkGameOver(Check1):-
    Check1 == 1.


gameOver:-
    write('GAME OVER!!!!!\n').

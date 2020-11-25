choosePiece(GameState, SelectBlackCol, SelectBlackRow, MoveDoneGameState, Player):-
    %need a repeat here in case of bad input
    repeat,
        format('\nChoose a ~w Piece!\n\n', Player),
        readFirstInput(SelectBlackCol, SelectBlackRow, ConfirmedBlackCol, ConfirmedBlackRow, Player, GameState),
        validateSecondInput(ConfirmedBlackCol, ConfirmedBlackRow, MoveCol, MoveRow, ConfirmedMoveCol, ConfirmedMoveRow, Player, GameState),
        movePiece(GameState, ConfirmedBlackCol, ConfirmedBlackRow, ConfirmedMoveCol, ConfirmedMoveRow, MoveDoneGameState, Player).

movePiece(GameState, ConfirmedBlackCol, ConfirmedBlackRow, ConfirmedMoveCol, ConfirmedMoveRow, MoveDoneGameState, Player):-
    getMatrixAt(ConfirmedBlackRow, ConfirmedBlackCol, GameState, Content),
    nl,
    getMatrixAt(ConfirmedMoveRow, ConfirmedMoveCol, GameState, MoveContent),
    %write('\nhello\n'),
    replaceEmpty(GameState, ConfirmedBlackRow, ConfirmedBlackCol, [empty, 0], NewGameState),
    replaceCell(NewGameState, ConfirmedMoveRow, ConfirmedMoveCol, Content, MoveDoneGameState),
    nl.


readFirstInput(Col, Row, ConfirmedCol, ConfirmedRow, Player, GameState):-
    once(readCol(C1, Col)),
    once(readRow(R1, Row)),
    (
        validateFirstPiece(GameState, Player, Row, Col) ->
        (ConfirmedCol is Col, ConfirmedRow is Row);
        (
            nl, write('Must choose a '), write(Player), write(' piece!\n'),
            !,fail
        )
    ).


validateSecondInput(SelectCol, SelectRow, Col, Row, ConfirmedMoveCol, ConfirmedMoveRow, Player, GameState):-
    write('\nChoose your move:\n'),
    readCol(C1, Col),
    readRow(R1, Row),
    (
        checkMoves(GameState, Player, SelectCol, SelectRow, Col, Row, ConfirmedMoveCol, ConfirmedMoveRow) -> 
        (ConfirmedMoveCol is Col, ConfirmedMoveRow is Row, nl, write(ConfirmedMoveCol), write(ConfirmedMoveRow));
        write('\nInvalid move! Try again.\n'), !, fail
    ).


readCol(SelectCol, ConfirmedCol):-
    write('Column: '),
    read(SelectCol),
    checkCol(SelectCol, ConfirmedCol).

readRow(SelectRow, ConfirmedRow):-
    write('Row: '),
    read(SelectRow),
    checkRow(SelectRow, ConfirmedRow).

checkCol(0, ConfirmedCol):- ConfirmedCol=0.
checkCol(1, ConfirmedCol):- ConfirmedCol=1.
checkCol(2, ConfirmedCol):- ConfirmedCol=2.
checkCol(3, ConfirmedCol):- ConfirmedCol=3.
checkCol(4, ConfirmedCol):- ConfirmedCol=4.
checkCol(5, ConfirmedCol):- ConfirmedCol=5.
checkCol(_Col, ConfirmedCol):-
    write('Invalid column\n'),
    write('Select another column:\n'),
    readCol(Col, ConfirmedCol).

checkRow(0, ConfirmedRow):- ConfirmedRow = 0.
checkRow(1, ConfirmedRow):- ConfirmedRow = 1.
checkRow(2, ConfirmedRow):- ConfirmedRow = 2.
checkRow(3, ConfirmedRow):- ConfirmedRow = 3.
checkRow(4, ConfirmedRow):- ConfirmedRow = 4.
checkRow(5, ConfirmedRow):- ConfirmedRow = 5.
checkRow(_Row, ConfirmedRow):-
    write('Invalid row\n'),
    write('Select another row:\n'),
    readRow(Row, ConfirmedRow).


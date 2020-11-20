choosePiece(GameState, SelectWhiteCol, SelectWhiteRow, MoveDoneGameState, white):-
    %need a repeat here in case of bad input
    repeat,
        write('\nChoose White Piece:\n\n'),
        readFirstInput(SelectWhiteCol, SelectWhiteRow, ConfirmedWhiteCol, ConfirmedWhiteRow, white, GameState),
        movePiece(GameState, ConfirmedWhiteCol, ConfirmedWhiteRow, MoveDoneGameState, white).

movePiece(GameState, ConfirmedWhiteCol, ConfirmedWhiteRow, MoveDoneGameState, white):-
    getMatrixAt(ConfirmedWhiteRow, ConfirmedWhiteCol, GameState, Content),
    %nl,write(ConfirmedWhiteCol), write(ConfirmedWhiteRow),
    nl,write(Content),nl,
    %need a repeat here in case of bad input
    write('\n\nChoose your move:\n\n'),
    readCol(MoveWhiteCol, ConfirmedMoveCol),
    readRow(MoveWhiteRow, ConfirmedMoveRow),
    nl,write(ConfirmedMoveCol),write(ConfirmedMoveRow),
    %getMatrixAt(MoveWhiteRow, MoveWhiteCol, GameState, MoveContent),
    nl,
    checkMoves(GameState, white, ConfirmedWhiteCol, ConfirmedWhiteRow, ConfirmedMoveCol, ConfirmedMoveRow),
    getMatrixAt(ConfirmedMoveRow, ConfirmedMoveCol, GameState, AuxContent),
    nl,write(AuxContent),nl,
    %write('\nhello\n'),
    replaceEmpty(GameState, ConfirmedWhiteRow, ConfirmedWhiteCol, [empty, 0], NewGameState),
    replaceCell(NewGameState, ConfirmedMoveRow, ConfirmedMoveCol, Content, MoveDoneGameState),
    nl.
    %write(MoveDoneGameState),
    %nl,
    %getMatrixAt(MoveRow, MoveCol, MoveDoneGameState, AfterMoveContent).

    
choosePiece(GameState, SelectBlackCol, SelectBlackRow, MoveDoneGameState, black):-
    %need a repeat here in case of bad input
    repeat,
        write('\nChoose Black Piece:\n\n'),
        readFirstInput(SelectBlackCol, SelectBlackRow, ConfirmedBlackCol, ConfirmedBlackRow, black, GameState),
        movePiece(GameState, ConfirmedBlackCol, ConfirmedBlackRow, MoveDoneGameState, black).

movePiece(GameState, ConfirmedBlackCol, ConfirmedBlackRow, MoveDoneGameState, black):-
    getMatrixAt(ConfirmedBlackRow, ConfirmedBlackCol, GameState, Content),
    nl,write(Content),nl,
    write('\n\nChoose your move:\n\n'),
    readCol(MoveBlackCol, ConfirmedMoveCol),
    readRow(MoveBlackRow, ConfirmedMoveRow),
    getMatrixAt(ConfirmedMoveRow, ConfirmedMoveCol, GameState, MoveContent),
    write(MoveContent),
    nl,
    %write('\nhello\n'),
    replaceEmpty(GameState, ConfirmedBlackRow, ConfirmedBlackCol, [empty, 0], NewGameState),
    replaceCell(NewGameState, ConfirmedMoveRow, ConfirmedMoveCol, Content, MoveDoneGameState),
    nl.
    %write(MoveDoneGameState),
    %nl,
    %getMatrixAt(MoveRow, MoveCol, MoveDoneGameState, AfterMoveContent).



readFirstInput(Col, Row, ConfirmedCol, ConfirmedRow, Player, GameState):-
    readCol(C1, Col),
    readRow(R1, Row),
    (
        validatePiece(GameState, Player, Row, Col) ->
        (ConfirmedCol is Col, ConfirmedRow is Row, write(ConfirmedCol), write(ConfirmedRow),nl);
        (
            nl, write('Must choose a '), write(Player), write(' piece!\n'),
            !,fail
        )
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


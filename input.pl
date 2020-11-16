movePiece(GameState, SelectWhiteCol, SelectWhiteRow, Content, MoveDoneGameState, 'white'):-
    %need a repeat here in case of bad input
    write('\nChoose White Piece:\n\n'),
    readCol(SelectWhiteCol),
    readRow(SelectWhiteRow),
    getMatrixAt(SelectWhiteRow, SelectWhiteCol, GameState, Content),

    %need a repeat here in case of bad input
    write('\n\nChoose your move:\n\n'),
    readCol(MoveWhiteCol),
    readRow(MoveWhiteRow),
    getMatrixAt(MoveWhiteRow, MoveWhiteCol, GameState, MoveContent),
    nl,
    %write(GameState),
    nl,
    %write('\nhello\n'),
    replaceEmpty(GameState, SelectWhiteRow, SelectWhiteCol, [empty, 0], NewGameState),
    replaceCell(NewGameState, MoveWhiteRow, MoveWhiteCol, Content, MoveDoneGameState),
    nl.
    %write(MoveDoneGameState),
    %nl,
    %getMatrixAt(MoveRow, MoveCol, MoveDoneGameState, AfterMoveContent).


movePiece(GameState, SelectCol, SelectRow, Content, MoveDoneGameState, 'black'):-
    write('\nChoose Black Piece:\n\n'),
    readCol(SelectCol),
    readRow(SelectRow),
    getMatrixAt(SelectRow, SelectCol, GameState, Content),

    write('\n\nChoose your move:\n\n'),
    readCol(MoveCol),
    readRow(MoveRow),
    getMatrixAt(MoveRow, MoveCol, GameState, MoveContent),

    nl,
    %write(GameState),
    nl,
    %write('\nhello\n'),
    replaceEmpty(GameState, SelectRow, SelectCol, [empty, 0], NewGameState),
    replaceCell(NewGameState, MoveRow, MoveCol, Content, MoveDoneGameState),
    nl.
    %write(MoveDoneGameState),
    %nl,
    %getMatrixAt(MoveRow, MoveCol, MoveDoneGameState, AfterMoveContent).

swapPlayers(1, 2).
swapPlayers(2, 1).

readCol(Col):-
    write('Column: '),
    read(Col).

readRow(Row):-
    write('Row: '),
    read(Row).

checkCol(0, SelectCol):- SelectCol=0.
checkCol(1, SelectCol):- SelectCol=1.
checkCol(2, SelectCol):- SelectCol=2.
checkCol(3, SelectCol):- SelectCol=3.
checkCol(4, SelectCol):- SelectCol=4.
checkCol(5, SelectCol):- SelectCol=5.
checkCol(_Col, SelectCol):-
    write('Invalid column\n'),
    write('Select another column: '),
    readCol(NewColumn),
    checkCol(NewColumn, SelectCol).

checkRow(0, SelectRow):- SelectRow = 0.
checkRow(1, SelectRow):- SelectRow = 1.
checkRow(2, SelectRow):- SelectRow = 2.
checkRow(3, SelectRow):- SelectRow = 3.
checkRow(4, SelectRow):- SelectRow = 4.
checkRow(5, SelectRow):- SelectRow = 5.
checkRow(_Row, SelectRow):-
    write('Invalid row\n'),
    write('Select another row: '),
    readCol(NewRow),
    checkCol(NewRow, SelectRow).
/*
checkColMove(SelectCol, MoveCol, MovedCol, FinalCol):-
    MoveCol=:=SelectCol+1, MovedCol = 1, FinalCol is MoveCol;
    MoveCol=:=SelectCol-1, MovedCol = 1, FinalCol is MoveCol;
    MoveCol=:=SelectCol, MovedCol = 0, FinalCol is MoveCol;
    (
        write('\nInvalid column move.\n'),
        write('Select another column move: '),
        readCol(NewCol),
        checkCol(NewCol, NewMoveCol),
        checkColMove(SelectCol, NewMoveCol, MovedCol, FinalCol)
    ).

checkRowMove(SelectRow, MoveRow, MovedRow, FinalRow):-
    MoveRow=:=SelectRow+1, MovedRow = 1, FinalRow is MoveRow;
    MoveRow=:=SelectRow-1, MovedRow = 1, FinalRow is MoveRow;
    MoveRow=:=SelectRow, MovedRow = 0, FinalRow is MoveRow;
    (
        write('\nInvalid row move.\n'),
        write('Select another row move: '),
        readCol(NewRow),
        checkCol(NewRow, NewMoveRow),
        checkColMove(SelectRow, NewMoveRow, MovedRow, FinalRow)
    ).*/

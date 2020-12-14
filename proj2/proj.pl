:-consult('display.pl').
play:-
    write('\33\[2J'),
    write('\n      WELCOME TO CHESS-NUM!     \n\n\n'),
    write('1. Board 1\n'),
    read(Selection),
    (
    Selection is 1,
    start
    ;
    true
    ).
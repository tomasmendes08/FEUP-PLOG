:-consult('display.pl').
:-consult('creation.pl').

play:-
    write('\33\[2J'),
    write('\n      WELCOME TO CHESS-NUM!     \n\n\n'),
    write('1. Board 1\n'),
    write('2. Board 2\n'),
    read(Selection),
    (
    Selection is 1,
    start
    ;
    Selection is 2,
    start2
    ;
    true
    ).
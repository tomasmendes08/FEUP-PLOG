:-consult('display.pl').
:-consult('creation.pl').
:-consult('horse.pl').
:-consult('attacks.pl').
:-use_module(library(lists)).
:-use_module(library(random)).

% load proj.pl / write play. / write 1.

play:-
    write('\33\[2J'),
    write('\n      WELCOME TO CHESS-NUM!     \n\n\n'),
    write('1. Board 1\n'),
    write('2. Board 2\n'),
    write('3. Board 3\n'),
    write('4. Board 4\n'),
    write('5. Board 5\n'),
    repeat,
    read(Selection),
    (
    Selection is 1,
    start(1)
    ;
    Selection is 2,
    start(2)
    ;
    Selection is 3,
    start(3)
    ;
    Selection is 4,
    start(4)
    ;
    Selection is 5,
    start(5)
    ;
    write('Wrong input, please try again\n'),
    false
    ).
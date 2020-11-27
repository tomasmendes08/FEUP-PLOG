:- use_module(library(lists)).
:-consult('play.pl').
:-consult('display.pl').
:-consult('input.pl').
:-consult('utils.pl').
%Para começar dar load do proj.pl e usar comando play.

play:-
    write('1. Play Player vs Player\n'),
    write('2. Play Player vs BotEasy\n'),
    write('3. Play Player vs BotHard\n'),
    write('4. Play Bot vs Bot\n'),
    read(Selection),
    (
    Selection is 1,
    start
    ;
    true
    ).


# PLOG 2020/2021

## Group T4G04
| Name             | Number    | E-Mail             |
| ---------------- | --------- | ------------------ |
| Pedro Coelho     | 201806802 | up201806802@fe.up.pt                |
| Tomás Mendes     | 201806522 | up201806522@fe.up.pt           |



## Greener

**Greener** is the second game of the *GreenGreenerGreenest*. *Green*, *Greener* and *Greanest* are three games that use the same set of components.

_Greener_ is a capturing game for 2 players, where both must capture the same colour.

**Basic Board**: a 6×6 board, 9 black pyramids, 18 green pyramids, 9 white pyramids.

**Gameplay overview**:

 - **Preparation**:

	The board starts full of pyramids. Each player has an allocated colour (Black or White) and green is a neutral colour.

 - **Starting**:

	Black starts. Players alternate turns during the game until both players pass in succession. On your turn, you must make one capture  if possible. Otherwise, you pass the turn. 

 - **Development**:
 
	Stacks capture other stacks that are on the same row or column and with no other stacks in between them, by stacking on top of them. This way, stacks cannot be split. 

 - **End**:
 
	 The game ends when both players pass in succession.
	 
 - **Objective**:

	The player with the most green pyramids captured (being part of stacks they control) wins the game. In case of a tie, the player with the highest stack wins. If the tie persists, play again.

[Official](https://boardgamegeek.com/boardgame/226081/greener) [Rules](https://nestorgames.com/rulebooks/GREENGREENERGREENEST_EN.pdf)


## Internal representation of the GameState

### Board 
As a way of representing the board, we use lists within a list.
The game allows stacking pieces, so we decided to make the first argument of each cell the colour of the piece on top of the stack and the second represents the number of green pieces in that specific stack. 
Furthermore, after a move, when a cell doesn't contain any content, we will put a list with a string called empty and a 0.

#### Initial Situation

````
initialBoard([

[[green,1], [white,0], [black,0], [green,1], [black,0], [green,1]],

[[black,0], [green,1], [green,1], [white,0], [green,1], [white,0]],

[[green,1], [white,0], [black,0], [green,1], [black,0], [green,1]],

[[black,0], [white,0], [green,1], [green,1], [green,1], [white,0]],

[[green,1], [green,1], [green,1], [green,1], [white,0], [black,0]],

[[white,0], [white,0], [black,0], [green,1], [black,0], [green,1]]

]).
````

##### Initial Situation From Sicstus
![First Board](https://github.com/tomasmendes08/PLOG/blob/main/images/initialboard.png?raw=true)
 
#### Intermediate Situation
````
midgameBoard([

[[white,2], [empty,0], [empty,0], [empty,0], [black,0], [green,1]],

[[black,0], [green,1], [green,1], [empty,0], [white,2], [empty,0]],

[[green,1], [white,0], [black,0], [empty,0], [black,0], [green,1]],

[[empty,0], [white,0], [green,1], [green,1], [green,1], [black,0]],

[[empty,0], [green,1], [green,1], [white,2], [empty,0], [empty,0]],

[[black,0], [white,0], [black,0], [green,1], [black,0], [green,1]]

]).
````
 
##### Intermediate Situation From Sicstus

![Mid Board](https://github.com/tomasmendes08/PLOG/blob/main/images/midgame.png?raw=true)

#### Final Situation

````
endgameBoard([

[[empty,0], [empty,0], [empty,0], [empty,0], [empty,0], [green,1]],

[[empty,0], [white,8], [empty,0], [empty,0], [empty,0], [empty,0]],

[[empty,0], [empty,0], [empty,0], [empty,0], [empty,0], [empty,0]],

[[empty,0], [empty,0], [black,6], [empty,0], [empty,0], [empty,0]],

[[empty,0], [empty,0], [empty,0], [empty,0], [black,3], [empty,0]],

[[empty,0], [empty,0], [empty,0], [empty,0], [empty,0], [empty,0]]

]).
````

##### Final Situation From Sicstus
   
![EndBoard](https://github.com/tomasmendes08/PLOG/blob/main/images/endgame.png?raw=true)
## GameState Visualization
For an intuitive visualization, we used **W**, **B**, **G** and " " to represent white, black, green and empty, respectively. Next to the symbol is the number of points or, in other words, the number of green pieces in the stack.

This way, we made a predicate called ````symbol(Piece, Points, Symbol)```` to convert  our values when they are being printed out.

In order to print the board, we use mainly four predicates: ````printBoard(Board)````, that prints the columns' indexes and then calls the second predicate; ````printLines(Board, ColumnNumber)````, that recursively formats the line for the third predicate to fill; finally, ````printLinesAux(BoardLine)````, that prints the entire line by calling ````printCell(BoardLineHead)```` which prints the content of each cell in a user friendly manner.





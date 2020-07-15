#!/bin/bash -x
echo "Weclome to Tic Tac Toe Game."
TOTAL_CELL=9
count=0
switchPlayer=1
playerLetter=O
computerLetter=X
declare -a board
 function resettingBoard() {
        board=(. . . . . . . . . .)
}

 function displayBoard() {

        echo -e "****** Tic-Tac-Toe ******* \n|  ${board[1]}  ||  ${board[2]}  ||  ${board[3]}  |\n---------------------\n| ${board[4]}   ||  ${board[5]}  ||  ${board[6]}  |\n-------------------\n|  ${board[1]}  ||  ${board[2]}  ||  ${board[3]}  |"

}
resettingBoard
displayBoard

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
  echo -e "****** Tic-Tac-Toe ******* \n|  ${board[1]}  ||  ${board[2]}  ||  ${board[3]}  |\n---------------------\n| ${board[4]}   ||  ${board[5]}  ||  ${board[6]}  |\n-------------------\n|  ${board[7]}  ||  ${board[8]}  ||  ${board[9]}  |"

}

function tossToPlay() {
    if [ $((RANDOM%2)) -eq 0 ]
    then
    switchPlayer=0
    echo "Player will play first."
    read -p "choose your letter X or O : " l
      if [[ $l == $computerLetter ]]
      then
         playerLetter=$l
         computerLetter=O
      else
         playerLetter=$l
         computerLetter=X
      fi
    else
       echo "Computer will play first."
    fi
}

resettingBoard
displayBoard
tossToPlay

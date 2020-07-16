#!/bin/bash -x
echo "Weclome to Tic Tac Toe Game."
TOTAL_CELL=9
count=0
ROW=3
switchPlayer=1
playerLetter=O
computerLetter=X
declare -a board
function resettingBoard() {
    board=(. . . . . . . . . .)
}

function empty() {
    index=0
    for((cell=1;cell<=TOTAL_CELL;cell++)){
       if [[ ${board[$cell]} == . ]]
       then
            emptyCells[$index]=$cell
            let index++
       fi
}
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
function computerPlaying() {
    echo "========================="
    echo "Computer turn: "
    computerPlayingToWin
    computerPlayingToBlock
    if [[ $block == 0 ]]
    then
         takeAvailableCorners
    fi
    switchPlayer=0
    displayBoard
}


function switchPlayer() {
    if [[ $switchPlayer == 0 ]]
    then
         playerPlaying
    else
         computerPlaying
    fi
    winningCondition $turnChange
}

function checkingEmptyCell() {
   if [[ $position -ge 1 && $position -le 9 ]]
   then
      if [[ ${board[$position]} == . ]]
      then
      echo "............ $turnChange is placed at $position ............"
      ((count++))
      else
      echo "Cell is already occupied!!!"
      switchPlayer
      fi
  else
      echo "Invalid cell value!!!"
      switchPlayer
  fi
}


function playerPlaying() {
    echo "==========================="
    echo "Player turn: "
    displayBoard
    echo "player latter : $playerLetter computer latter : $computerLetter"
    echo "Empty Cells :${emptyCells[@]}"
    read -p "Select your Cell : " position
    turnChange=$playerLetter
    checkingEmptyCell
    board[$position]=$playerLetter
    switchPlayer=1
}

function winningCondition(){
    for((cell=1;$cell<=$TOTAL_CELL;cell=$(($cell+3))))
    do
       if [[ ${board[$cell]} == ${board[$cell+1]} && ${board[$cell+1]} == ${board[$cell+2]} && ${board[$cell+2]} == $1 ]]
       then
           winner=1
       fi
    done
    for((cell=1;$cell<=$ROW;cell++))
    do
        if [[ ${board[$cell]} == ${board[$cell+3]} && ${board[$cell+3]} == ${board[$cell+6]} && ${board[$cell]} == $1 ]]
        then
           winner=1
        fi
    done
    for((cell=1;$cell<=$TOTAL_CELL;cell++))
    do
        if [[ ${board[$cell]}  == ${board[$cell+4]} && ${board[$cell+4]} == ${board[$cell+8]} && ${board[$cell+8]} == $1 ]]
        then
           winner=1
        elif [[ ${board[$cell]}  == ${board[$cell+4]} && ${board[$cell+4]} == ${board[$cell+6]} && ${board[$cell+6]} == $1 ]]
        then
           winner=1
        fi
    done
}

function computerPlayingToWin() {
   for((cell=1;cell<=$TOTAL_CELL;cell++))
   do
     if [[ ${board[$cell]} == . ]]
     then
     board[$cell]=$computerLetter
     winningCondition $computerLetter
      if [[ $winner -eq 1 ]]
      then
        displayBoard
        echo "Winner is computer"
        exit
      else
        board[$cell]="."
        block=0
      fi
    fi
 done
}

function computerPlayingToBlock() {
   for((cell=1;cell<=$TOTAL_CELL;cell++))
   do
     if [[ ${board[$cell]} == . ]]
     then
     board[$cell]=$playerLetter
     winningCondition $playerLetter
       if [[ $winner -eq 1 ]]
       then
         board[$cell]=$computerLetter
         winner=0
         #block=1
         ((count++))
         displayBoard
         break
       else
         board[$cell]="."
       fi
     fi
   done
}

function takeAvailableCorners() {
  for((cell=1;cell<=$TOTAL_CELL;cell=$cell+2))
  do
      local flag=5
    if [[ $cell == $flag ]]
    then
    cell=$(($cell+2))
    fi
    if [[ ${board[$cell]} == . ]]
    then
    board[$cell]=$computerLetter
    local center=1
    ((count++))
    break
    fi
 done
}


function takeCenter() {
    if [[ $center -ne 1 ]]
    then
    local middle=$(($TOTAL_CELL+1))/2
       if [[  ${board[$middle]} == . ]]
       then
           board[$middle]=$computerLetter
           ((count++))
       else
           takeAvailableSides
       fi
    fi
}

function takeAvailableSides() {
   for((cell=2;cell<=8;cell+=2))
   do
      if [[ ${board[$cell]} == . ]]
      then
      board[$cell]=$computerLetter
      ((count++))
      break
      fi
   done
}

function checkingGameStatus() {
    if [[ $winner -eq 1 ]]
    then
    displayBoard
    echo "Winner is $turnChange's"
    exit
    elif [[ $count -ge $TOTAL_CELL ]]
    then
    echo "=========================="
    displayBoard
    echo "game is tie"
    fi
}

resettingBoard
tossToPlay
empty
switchPlayer
checkingGameStatus
emptyCells=()
displayBoard

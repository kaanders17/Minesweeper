/********* VARIABLES *********/
// We control which screen is active by settings / updating
// gameScreen variable. We display the correct screen according
// to the value of this variable.
// 
// 0: Initial Screen
// 1: Game Screen
// 2: Game-over Screen 
int gameScreen = 0;



/********* SETUP BLOCK *********/
void setup() {
size(400, 400);
// set the initial coordinates of the
smooth();
}
/********* DRAW BLOCK *********/
void draw() {
// Display the contents of the current screen
if (gameScreen == 0) { 
    initScreen();
    keyPressed();
  } else if (gameScreen == 1) { 
    gameScreen();
    if(isWon() == true){
      //System.out.println("Won");
      gameWon();
    }
  } else if (gameScreen == 2) { 
    gameLostScreen();
    System.out.println("Lose");
  } else if (gameScreen == 3) { 
    gameWonScreen();
    System.out.println("Win");
  }
  
}

//Levels
public void keyPressed(){
  if(key == 'h'){
    NUM_ROWS = 15;
    NUM_COLS = 15;
    NUM_Mines = 8;
    System.out.println("Hard");
    textSize(3);
    startGame();
  }
  if(key == 'e'){
    NUM_ROWS = 5;
    NUM_COLS = 5;
    NUM_Mines = 1;
    System.out.println("Easy");
    startGame();
  }
  if(key == 'm'){
    NUM_ROWS = 10;
    NUM_COLS = 10;
    NUM_Mines = 5;
    System.out.println("Medium");
    textSize(10);
    startGame();
  }
}
/********* SCREEN CONTENTS *********/
void initScreen() {
background(236, 240, 241);
textAlign(CENTER);
fill(52, 73, 94);
textSize(60);
text("Minesweeper", width/2, height/2);
textSize(15); 
text("Click Key to Access Levels", width/2, height-70);
text("E - Easy, M - Medium, H - Hard", width/2, height-50);
text("Click to start", width/2, height-30);
}
void gameScreen() {
background(236, 240, 241);
textSize(70);
text("Game", width/2, height/2);

}
void gameLostScreen() {
background(44, 62, 80);
textAlign(CENTER);
fill(236, 240, 241);
for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++){
    fill(0, 255, 0);
    Interactive.setActive(buttons[r][c], false);
   }
}
textSize(15);
text("Haha I win you loose", width/2, height-80);
text("Click to Restart", width/2, height-30);
}
void gameWonScreen() {
background(44, 62, 80);
textAlign(CENTER);
for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++){
    fill(0, 255, 0);
    Interactive.setActive(buttons[r][c], false);
   }
}
fill(236, 240, 241);
textSize(15);
text("You won!", width/2, height-80);
text("Click to Restart", width/2, height-30);
}
/********* INPUTS *********/
public void mousePressed() {
// if we are on the initial screen when clicked, start the game 
if (gameScreen==0) { 
    startGame();
  }
if (gameScreen==2) {
    restart();
  }
if (gameScreen==3) {
    restart();
  }
}
/********* OTHER FUNCTIONS *********/
// This method sets the necessery variables to start the game  
void startGame() {
  gameScreen=1;
    textAlign(CENTER,CENTER);
    textSize(5);
    
    // make the manager
    Interactive.make(this);
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r, c);
      }
    }
    for(int i = 0; i < NUM_Mines; i++){
      setMines();
    }
    background(0);
    //System.out.println("Won");
    //if(isWon() == true){
    //  System.out.println("Won");
    //  //gameWon();
    //}
    
}
void gameLost() {
  gameScreen=2;
}
void gameWon() {
  gameScreen=3;
}
void restart() {
  gameScreen = 0;
}



//Download 3.5
import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 5;
private int NUM_COLS = 5;
private int NUM_Mines = 1;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines =  new ArrayList<MSButton>();//ArrayList of just the minesweeper buttons that are mined


public void setMines()
{
  int randomR = (int)(Math.random()*NUM_ROWS);
  int randomC = (int)(Math.random()*NUM_COLS);
  if(!mines.contains(buttons[randomR][randomC])){
    mines.add(buttons[randomR][randomC]);
  }
}

public boolean isWon()
{
  boolean won = true;
  for(int i = 0; i < buttons.length; i++){
    for(int j = 0; j < buttons[i].length; j++){
      if(!mines.contains(buttons[i][j]) && buttons[i][j].clicked == false){
        won = false;
      }
    }
  }
    //your code here
    return won;
}
//public void displayLosingMessage()
//{
//    textAlign(CENTER);
//    stroke(0);
//    strokeWeight(3);
//    text("Haha I win you lose", 200, 200);
//    //your code here
//}
//public void displayWinningMessage()
//{
//    textAlign(CENTER);
//    stroke(0);
//    strokeWeight(3);
//    text("You win", 200, 200);
//    //your code here
//}
public boolean isValid(int r, int c)
{
    return (r < NUM_ROWS) && (r >= 0) && (c < NUM_COLS) && (c >= 0);
}
public int countMines(int row, int col)
{
    int numMines = 0;
  if((isValid(row - 1, col - 1)) && (mines.contains(buttons[row - 1][col - 1]))){
    numMines++;
  }
  if((isValid(row - 1, col)) && (mines.contains(buttons[row - 1][col]))){
    numMines++;
  }if((isValid(row - 1, col + 1)) && (mines.contains(buttons[row - 1][col + 1]))){
    numMines++;
  }if((isValid(row, col - 1)) && (mines.contains(buttons[row][col - 1]))){
    numMines++;
  }if((isValid(row, col + 1)) && (mines.contains(buttons[row][col + 1]))){
    numMines++;
  }if((isValid(row + 1, col - 1)) && (mines.contains(buttons[row + 1][col - 1]))){
    numMines++;
  }if((isValid(row + 1, col)) && (mines.contains(buttons[row + 1][col]))){
    numMines++;
  }if((isValid(row + 1, col + 1)) && (mines.contains(buttons[row + 1][col + 1]))){
    numMines++;
  }
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add(this); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
          flagged = !flagged;
          if(flagged == false){
            clicked = false;
          }
        }
        else if(mines.contains(this)){
          gameScreen = 2;
        }
        else if(countMines(myRow, myCol) > 0){
          myLabel = "" + countMines(myRow, myCol);
        }
        else{
          this.mousePressed();
        }
        //your code here
    }
    public void draw () 
    {    
        if (flagged){
            fill(0);
        }
        else if(clicked && mines.contains(this)){
             fill(255,0,0);
             gameScreen = 2;
        }
        else if(clicked){
            fill( 200 );
        }
        else{
            fill( 100 );
        }

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

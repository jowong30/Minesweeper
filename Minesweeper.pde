import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 10;
int NUM_COLS = 10;
int NUMINES = 1;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(700, 700);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    mines = new ArrayList <MSButton>();
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS] [NUM_COLS];
    for(int i = 0; i<NUM_COLS; i++){
        for(int u =0; u< NUM_COLS; u++){
            buttons[i][u] =  new MSButton(i,u);
        }
    }
    
    setMines();
}
public void setMines()
{
    //your code
    while(mines.size()< NUMINES){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(mines.contains(buttons[row][col])){
            setMines();
        }else{
            mines.add(buttons[row][col]);
        }

        System.out.println(row + " , " + col);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    text("You Lost", 100 , 100);
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if(r <NUM_ROWS && c < NUM_ROWS && r > -1 && c > -1){
        return true;
      }
      return false;

}
public int countMines(int row, int col)
{
    int numMines = 0;

      for(int r = row-1; r<row+2; r++){
        for(int c = col - 1; c<col+2; c++){
            if(isValid(r,c) && mines.contains(buttons[r][c])){
              numMines ++;
            }
        }
      }
      if(mines.contains(buttons[row][col])){
        numMines --;
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
        width = 700/NUM_COLS;
        height = 700/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT) {
            if(flagged == false){
                flagged = true;
            }else{
                flagged = false;
                clicked = false;
            }
        }else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(myRow,myCol)>0){
            setLabel(countMines(myRow, myCol));
        }else{

            for(int r = myRow-1; r<myRow+2; r++){
                for(int c = myCol - 1; c<myCol+2; c++){
                    buttons[r][c].clicked = true;
                    
                    
                }
            }           
        }
        //your code here
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

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

//-------------------------------------------------------------------------------------WRITTEN BY nauticalmile
//button class, for engineer notes of spring.
//main methods are following functions.
//button:constructor of this class.
//void render:render the button.
//Boolean pressed: button pressed processing.
//Boolean released: button released processing.
//Boolean judge: button area judgement.
//---------------------------------------------------------------------------------------------------------

class button{
  //-----MEMBERS-------------------------------------------------------------------------------MEMBERS
  PFont buttonFont;
  PVector buttonPosition;
  PVector buttonSize;
  String labelText;
  int labelSize;
  color buttonPushed, buttonReleased;
  Boolean buttonStatus;
  Boolean buttonPressed;
  
  
  //-------------------------------------------------------------------------------------------METHODS
  //--------------------------------------------------------------------------------CONSTRUCTOR
  button(int pos_x, int pos_y, int size_x, int size_y, String label){
    buttonPosition = new PVector(pos_x, pos_y);
    buttonSize = new PVector(size_x, size_y);
    labelText = label;
    labelSize = int(size_y*0.5);
    buttonFont = createFont("MS-PGothic", labelSize);
    buttonPushed = color(155, 155, 255, 250);
    buttonReleased = color(255, 255, 255, 150);
    buttonStatus = false;
    buttonPressed = false;
  }
  
  //RENDERER FUNCTION------------------------------------------------------------RENDER FUNCTION
  void render(){
    fill(0, 0, 0, 100);
    rect(buttonPosition.x, buttonPosition.y, buttonSize.x, buttonSize.y);
    
    if(buttonPressed){
      fill(buttonPushed);
      rect(buttonPosition.x+3, buttonPosition.y+3, buttonSize.x-5, buttonSize.y-5);
    }else{
      fill(buttonReleased);
      rect(buttonPosition.x+1, buttonPosition.y+1, buttonSize.x-3, buttonSize.y-3);
    }
    fill(20, 20, 20);
    
    textSize(labelSize);
    textFont(buttonFont);
    text(labelText, buttonPosition.x+5, buttonPosition.y+buttonSize.y-5);
  }
  
  //----------------------------------------------------------------------BUTTON PRESSED PROCESSING
  Boolean pressed(int mouse_x, int mouse_y){
    if(mouse_x > buttonPosition.x && mouse_x < buttonPosition.x+buttonSize.x){
      if(mouse_y > buttonPosition.y && mouse_y < buttonPosition.y+buttonSize.y){
        buttonPressed = true;
        return true;
      }else return false;
    }else return false;
  }
  
  //----------------------------------------------------------------------BUTTON RELEASED PROCESSING
  Boolean released(int mouse_x, int mouse_y){
    Boolean ready;
    if(buttonPressed) ready = true;
    else ready = false;
    buttonPressed = false;
    if(mouse_x > buttonPosition.x && mouse_x < buttonPosition.x+buttonSize.x){
      if(mouse_y > buttonPosition.y && mouse_y < buttonPosition.y+buttonSize.y){
        if(ready) return true;
        else return false;
      }else return false;
    }else return false;
  }
    
  //----------------------------------------------------------------------BUTTON AREA JUDGEMENT
  Boolean judge(int mouse_x, int mouse_y){
    if(mouse_x > buttonPosition.x && mouse_x < buttonPosition.x+buttonSize.x){
      if(mouse_y > buttonPosition.y && mouse_y < buttonPosition.y+buttonSize.y){
        return true;
      }else return false;
    }else return false;
  }
}
    
    
    

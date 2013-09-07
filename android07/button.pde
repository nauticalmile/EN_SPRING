class button{
  //-----MEMBERS----------------------------------------------------------
  PFont buttonFont;
  PVector buttonPosition;
  PVector buttonSize;
  String labelText;
  int labelSize;
  color buttonPushed, buttonReleased;
  Boolean buttonStatus;
  int buttonPressedCounter;
  
  
  //-----METHODS----------------------------------------------------------
  //CONSTRUCTOR
  button(int pos_x, int pos_y, int size_x, int size_y, String label){
    buttonPosition = new PVector(pos_x, pos_y);
    buttonSize = new PVector(size_x, size_y);
    labelText = label;
    labelSize = int(size_y*0.5);
    buttonFont = createFont("MS-PGothic", labelSize);
    buttonPushed = color(255, 255, 180, 10);
    buttonReleased = color(255, 255, 255, 10);
    buttonStatus = false;
    buttonPressedCounter = 0;
  }
  
  void render(){
    fill(0, 0, 0, 100);
    rect(buttonPosition.x, buttonPosition.y, buttonSize.x, buttonSize.y);
    
    if(buttonPressedCounter >= 0){
      fill(buttonPushed);
      buttonPressedCounter--;
    }else fill(buttonReleased);
    rect(buttonPosition.x+1, buttonPosition.y+1, buttonSize.x-3, buttonSize.y-3);
    fill(220, 220, 220);
    
    textSize(labelSize);
    textFont(buttonFont);
    text(labelText, buttonPosition.x+5, buttonPosition.y+buttonSize.y-5);
  }
  
  Boolean judge(int mouse_x, int mouse_y){
    if(mouse_x > buttonPosition.x && mouse_x < buttonPosition.x+buttonSize.x){
      if(mouse_y > buttonPosition.y && mouse_y < buttonPosition.y+buttonSize.y){
        buttonPressedCounter = 5;
        return true;
      }else return false;
    }else return false;
  }
}
    
    
    

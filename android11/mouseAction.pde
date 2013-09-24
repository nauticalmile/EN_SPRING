class mouseAction{
  //-----MEMBERS-------------------------------------------------------------------------------MEMBERS
  int initialX, initialY;
  
  //-------------------------------------------------------------------------------------------METHODS
  //--------------------------------------------------------------------------------CONSTRUCTOR
  mouseAction(){
    initialX = 0;
    initialY = 0;
  }
  
  //RENDERER FUNCTION------------------------------------------------------------RENDER FUNCTION
  
  //----------------------------------------------------------------------MOUSE PRESSED PROCESSING
  void pressed(){
    initialX = mouseX;
    initialY = mouseY;
  }
  
  //----------------------------------------------------------------------MOUSE DRAGGED PROCESSING
  float getDistance(){
    return sq(mouseX-initialX)+sq(mouseY-initialY);
  }
    
}

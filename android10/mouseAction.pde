class mouseAction{
  //-----MEMBERS-------------------------------------------------------------------------------MEMBERS
  PVector initial;
  PVector stored;
  PVector render;
  int initialX, initialY;
  
  //-------------------------------------------------------------------------------------------METHODS
  //--------------------------------------------------------------------------------CONSTRUCTOR
  mouseAction(){
    initial = new PVector(0, 0);
    initialX = 0;
    initialY = 0;
    stored = new PVector(0, 0);
    render = new PVector(0, 0);
  }
  
  //RENDERER FUNCTION------------------------------------------------------------RENDER FUNCTION
  
  //----------------------------------------------------------------------BUTTON PRESSED PROCESSING
  void pressed(){
    initial.x = mouseX;
    initial.y = mouseY;
    initialX = mouseX;
    initialY = mouseY;
  }
  
  //----------------------------------------------------------------------BUTTON DRAGGED PROCESSING
  float dragged(){
    return sq(mouseX-initialX)+sq(mouseY-initialY);
  }
    
  //----------------------------------------------------------------------BUTTON AREA JUDGEMENT
}

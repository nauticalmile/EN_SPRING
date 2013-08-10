class button{
  //-----MEMBERS----------------------------------------------------------
  PVector buttonPosition;
  PVector buttonSize;
  String labelText;
  int labelSize;
  
  //-----METHODS----------------------------------------------------------
  //CONSTRUCTOR
  button(int pos_x, int pos_y, int size_x, int size_y, String label){
    buttonPosition = new PVector(pos_x, pos_y);
    buttonSize = new PVector(size_x, size_y);
    labelText = label;
    labelSize = 16;
  }
  
  void render(){
    fill(0, 0, 0);
    rect(buttonPosition.x, buttonPosition.y, buttonSize.x, buttonSize.y);
    fill(255, 255, 255);
    rect(buttonPosition.x+1, buttonPosition.y+1, buttonSize.x-3, buttonSize.y-3);
    fill(0, 0, 0);
    textSize(labelSize);
    text(labelText, buttonPosition.x+5, buttonPosition.y+buttonSize.y-5);
  }
  
  Boolean judge(int mouse_x, int mouse_y){
    if(mouse_x > buttonPosition.x && mouse_x < buttonPosition.x+buttonSize.x){
      if(mouse_y > buttonPosition.y && mouse_y < buttonPosition.y+buttonSize.y){
        return true;
      }else return false;
    }else return false;
  }
}
    
    
    

class numberKeyboard{
  //-----MEMBERS----------------------------------------------------------
  int areaWidth, areaHeight;
  int buttonWidth, buttonHeight;
  int marginWidth, marginHeight;
  button inputDisplay;
  button[] numButtons;
  String[] inputData;
  int numString;
  
  
  //-----METHODS----------------------------------------------------------
  numberKeyboard(int inputWidth, int inputHeight){
    areaWidth = inputWidth;
    areaHeight = inputHeight;
    marginWidth = 2;
    marginHeight = 2;
    buttonWidth = (int)((float)areaWidth/3.0f)-2*marginWidth;
    buttonHeight = (int)((float)areaHeight/6.0f)-2*marginHeight;
    numString = 15;
    inputData = new String[numString];
    for(int i = 0; i < numString; i++) inputData[i] = "0";
    inputDisplay = new button(marginWidth, marginHeight, areaWidth-2*marginWidth, 2*buttonHeight, "");
    inputDisplay.labelSize *= 2;
    numButtons = new button[12];
    int nx = 0;
    int ny = 0;
    String text = "";
    for(int i = 0; i < 12; i++){
      nx = i%3;
      if(i<9) text = str(i+1);
      else if(i==9) text = ".";
      else if(i==10) text = "0";
      else if(i==11) text = "ENT";
      numButtons[i] = new button(
        nx*buttonWidth+(2*nx+1)*marginWidth, 
        ny*buttonHeight+(2*ny+1)*marginHeight + 2*(buttonHeight+marginHeight), 
        buttonWidth, 
        buttonHeight, 
        text
      );
      if(nx == 2) ny++;
    }
  }
  
  void render(){
    textAlign(RIGHT);
    for(int i = 0; i < 12; i++){
      numButtons[i].render();
    }
    inputDisplay.labelText = "";
    for(int i = 0; i < numString; i++) inputDisplay.labelText += inputData[i];
    inputDisplay.render();
  }
  
  void buttonPressed(int X, int Y){
  }
}

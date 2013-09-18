/*20130811 written by nauticalmile*/

//Number keyboard interface for Android.
//under developping...

class numberKeyboard{
  //-----MEMBERS----------------------------------------------------------
  Boolean active;
  int areaWidth, areaHeight;
  int buttonWidth, buttonHeight;
  int marginWidth, marginHeight;
  button inputDisplay;
  button[] numButtons;
  String[] inputData;
  int numString;
  Boolean isDot;
  int numInputData;
  int counterAnimation;
  
  
  //-----METHODS----------------------------------------------------------
  numberKeyboard(int inputWidth, int inputHeight){
    
    //--------------------------------------------INITIALIZE VARIABLES
    active = true;
    areaWidth = inputWidth;
    areaHeight = inputHeight;
    marginWidth = 2;
    marginHeight = 2;
    buttonWidth = (int)((float)areaWidth/3.0f)-2*marginWidth;
    buttonHeight = (int)((float)areaHeight/6.0f)-2*marginHeight;
    counterAnimation = 5;
    
    //-------------------------------------------SETUP DISPLAY BUTTON
    numString = 7;
    numInputData = 0;
    isDot = false;
    inputData = new String[numString];
    for(int i = 0; i < numString; i++) inputData[i] = "";
    inputDisplay = new button(marginWidth, marginHeight, areaWidth-2*marginWidth, 2*buttonHeight, "");
    
    //--------------------------------------------SETUP NUMBER BUTTONS
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
      //---------------------------------------------BUTTON ALIGNMENT
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
  
  //-------------------------------------------------------------RENDER KEYBOARDS.
  void render(){
    if(active){
      textAlign(LEFT);
      
      //--------------------------------------------------------------Render keys
      if(counterAnimation >= 0) {
        pushMatrix();
        translate(0, counterAnimation*10);
        for(int i = 0; i < 12; i++) numButtons[i].render();
        counterAnimation--;
        popMatrix();
      }else{
        for(int i = 0; i < 12; i++) numButtons[i].render();
      }
      
      //-----------------------------------------------------------Render display
      inputDisplay.labelText = "";
      for(int i = 0; i < numString; i++) inputDisplay.labelText += inputData[i];
      if(counterAnimation >= 0){
        pushMatrix();
        translate(0, -counterAnimation*10);
        inputDisplay.render();
        popMatrix();
      }else{
        inputDisplay.render();
      }
    }
  }
  
  Boolean buttonPressed(int X, int Y){
    for(int i = 0; i < 12; i++) numButtons[i].pressed(X, Y);
    return true;
  }
  
  //Botton action processing
  float buttonReleased(int X, int Y){
    int buttonNumber = 0;
    Boolean hit = false;
    for(int i = 0; i < 12; i++){
      if( numButtons[i].released(X, Y) ){
        buttonNumber = i;
        hit = true;
        break;
      }
    }
    if(!hit) return 0.0f;
    else{ 
      //-------------------------------------------------------------------------------"ENTER" PROCESSING.
      if(buttonNumber == 11){
        active = false;
        return outputNumber();
      }
      //-------------------------------------------------------------------------------OTHER KEY PROCESSING.
      else{
        if(numInputData < numString){
          if(buttonNumber == 9){
            if(!isDot){
              inputData[numInputData] = ".";
              isDot = true;
            }
          }
          else if(buttonNumber == 10) inputData[numInputData] = str(0);
          else inputData[numInputData] = str(buttonNumber+1);
          numInputData++;
        }
        return 0.0f;
      }
    }
  }
  
  //--------------------------------------------OUTPUT THE DATA AND FINISH THE NUMBER KEYBOARD INTERFACE.
  float outputNumber(){
    float output = 0.0f;
    float exponential = 1.0f;
    int count = 0;
    //-------------------------------------------MAKE EXPRESSED BY STRING REPRESENTED BY FLOAT.
    for(int i = 0; i < numInputData; i++){
      if(inputData[numInputData-(i+1)] == "."){
        count = i;
      }else{
        for(int j = 0; j < 10; j++){
          if(inputData[numInputData-(i+1)] == str(j)){
            output += exponential*(float)j;
            exponential*=10.0;
            break;
          }
        }
      }
    }
    
    //------------------------------------------------------------Dot processing
    exponential = 1.0f;
    for(int i = 0; i < count; i++) exponential *= 0.1f;
    output *= exponential;
    
    //--------------------------------------------------------Initialize number keyboard
    for(int i = 0; i < numString; i++){
      inputData[i] = "";
    }
    numInputData = 0;
    isDot = false;
    counterAnimation = 5;
    
    return output;
  }
}

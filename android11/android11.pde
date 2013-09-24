import ketai.ui.*;
import android.view.MotionEvent;

springProperty SP;
numberKeyboard NKB;


String str_count;
color colText;
int page_number;
int indent_l;
int indent_h;
int align_h;
int buttonHeight;
PImage bg_image;
PFont main_font;
int main_font_size;
PFont large_font;
int large_font_size;
int animation_counter;

mouseAction myMouseAction;
int[] stored_offset;
int[] render_offset;

int numList;

String str_w, str_h;
String event_type;
String key_input;
float mx, my;
float pssr;
button keySwitch;
float constant;

KetaiList listMaterial;
materialButton listMaterialSelection;

int springType;
KetaiList listSpringType;
springTypeButton listSpringTypeButton;

int langageType;
KetaiList listLangageType;
langageTypeButton listLangageTypeButton;

int numData;
int dataNumber;
button[] buttonDataInput;
String[] buttonLabels;
float[] dataSpring;

button buttonMenu;
button buttonCalc;
button buttonData;


//-------------------------------------------------------------------------------SET UP FUNCTION
void setup(){
  println("SET UP EN_SPRING");
  orientation(PORTRAIT);
  frameRate(30);
  bg_image = loadImage("bg.jpg");
  page_number = 0;
  main_font_size = 12;
  main_font = createFont("Meiryo", main_font_size);
  large_font_size = 24;
  large_font = createFont("Meiryo", large_font_size);
  textSize(main_font_size);
  textAlign(LEFT);
  strokeWeight(10);
  colText = color(250, 250, 250);
  indent_l = 10;
  buttonHeight = 38;
  align_h = buttonHeight + 2;
  event_type = "NONE";
  pssr = 0;
  mx = 0;
  my = 0;
  noStroke();
  key_input = "a";
  keySwitch = new button(indent_l, align_h, width-2*indent_l, buttonHeight, "keyboard");
  
  //----------------------------------------------------------------------------------MOUSE ACTION SET UP
  myMouseAction = new mouseAction();
  render_offset = new int[3];
  stored_offset = new int[3];
  for(int i = 0; i < 3; i++){
    render_offset[i] = 0;
    stored_offset[i] = 0;
  }
  
  //---------------------------------------------------------------------------------HEADER MENU BUTTONS
  int devided_width = int(width/3.0);
  buttonMenu = new button(0, 0, devided_width, buttonHeight, "MENU");
  buttonCalc = new button(devided_width, 0, width-2*devided_width, buttonHeight, "CALC");
  buttonData = new button(width-devided_width, 0, devided_width, buttonHeight, "DATA");
  
  langageType = 1;
  listLangageTypeButton = new langageTypeButton(indent_l, align_h*3, width-2*indent_l, buttonHeight, "言語");
  springType = 0;
  listSpringTypeButton = new springTypeButton(indent_l, align_h*2, width-2*indent_l, buttonHeight, "バネの種類");
  
  //----------------------------------------------------------------------------------DATA INPUT BUTTONS
  listMaterialSelection = new materialButton(indent_l, align_h*2, width-2*indent_l, buttonHeight, "材質");
  numData = 9;
  dataSpring = new float[numData];
  buttonDataInput = new button[numData];
  buttonLabels = new String[numData];
  for(int i = 0; i < numData; i++){
    String buttonLabel = "";
    switch(i){
      case 0:
        buttonLabels[i] = "コイル線径";
        break;
      case 1:
        buttonLabels[i] = "平均径";
        break;
      case 2:
        buttonLabels[i] = "巻き数";
        break;
      case 3:
        buttonLabels[i] = "有効巻き数";
        break;
      case 4:
        buttonLabels[i] = "自由長";
        break;
      case 5:
        buttonLabels[i] = "第一荷重";
        break;
      case 6:
        buttonLabels[i] = "第一荷重長";
        break;
      case 7:
        buttonLabels[i] = "第二荷重";
        break;
      case 8:
        buttonLabels[i] = "第二荷重長";
        break;
      default:
        buttonLabels[i] = "NONE";
        break;
    }
    buttonDataInput[i] = new button(indent_l, align_h*(i+3), width-2*indent_l, buttonHeight, buttonLabels[i]);
  }
  dataNumber = 0;
  
  NKB = new numberKeyboard(width, height);
  NKB.active = false;
  
  println(PFont.list());
}


//--------------------------------------------------------------------------------------------DRAW FUNCTION
void draw(){
  background(255, 255, 255);
  //image(bg_image, 0, 0, width, height);
  if(NKB.active == false){
    pushMatrix();
    translate(0, render_offset[page_number]);
    //---------------------------CONDITIONAL BRANCH OF PAGE NUMBER
    if(page_number == 0){
      listSpringTypeButton.render();
      listLangageTypeButton.render();
    }else if(page_number == 1){
      listMaterialSelection.render();
      for(int i = 0; i < numData; i++) buttonDataInput[i].render();
    }else if(page_number == 2){
      indent_h = 100;
      for(int i = 0; i < 7; i++){
        indent_h += 30;
        if(i==0) text("SPRING PROPERTIES", indent_l, indent_h);
        if(i==1) text("Count=" + str(frameCount), indent_l, indent_h);
        if(i==2) text("w=" + str(width) + ", h=" + str(height), indent_l, indent_h);
        if(i==3) text("TOUCH: " + event_type, indent_l, indent_h);
        if(i==4) text(key_input , indent_l, indent_h);
        if(i==5) text("X=" + str(mx) + ", Y=" + str(my) + ", P=" + str(pssr), indent_l, indent_h);
        if(i==6) text(key_input, indent_l, indent_h);
      }
    }
    //-------------------------END OF CONDITIONAL BRANCH OF PAGE NUMBER
    //-------------------------HEADER MENU RENDERING
    popMatrix();
    fill(0, 0, 0, 100);
    rect(0, 0, width, buttonHeight*2);
    fill(colText);
    textFont(large_font);
    textSize(large_font_size);
    text("E.N.SPRING", indent_l, 60);
    buttonMenu.render();
    buttonCalc.render();
    buttonData.render();
    //------------------------END OF HEADER MENU RENDERING
  }else if(NKB.active){
    NKB.render();
  }
}

//-----------------------------------------------------------------------------------------------------Ketai LIST SELECTION
void onKetaiListSelection(KetaiList klist){
  String selected = klist.getSelection();
  if(numList == 0) springType = listSpringTypeButton.getConstant(selected);
  else if(numList == 1) langageType = listLangageTypeButton.getConstant(selected);
  else if(numList == 2) constant = listMaterialSelection.getConstant(selected);
}

//----------------------------------------------------------------------------------------------------MOUSE PRESSED FUNCTION
void mousePressed(){
  if(NKB.active){
    NKB.buttonPressed(mouseX, mouseY);
  }else{
    keySwitch.pressed(mouseX, mouseY);
    buttonMenu.pressed(mouseX, mouseY);
    buttonCalc.pressed(mouseX, mouseY);
    buttonData.pressed(mouseX, mouseY);
    if(page_number == 0){
      listSpringTypeButton.pressed(mouseX, mouseY-render_offset[page_number]);
      listLangageTypeButton.pressed(mouseX, mouseY-render_offset[page_number]);
    }else if(page_number == 1){
      listMaterialSelection.pressed(mouseX, mouseY-render_offset[page_number]);
      for(int i = 0; i < numData; i++) buttonDataInput[i].pressed(mouseX, mouseY-render_offset[page_number]);
    }
    KetaiKeyboard.hide(this);
  }
  myMouseAction.pressed();
}

//-----------------------------------------------------------------------------------------------------MOUSE RELEASED FUNCTION
void mouseReleased(){
  if(NKB.active){
    dataSpring[dataNumber] = NKB.buttonReleased(mouseX, mouseY);
    buttonDataInput[dataNumber].labelText = buttonLabels[dataNumber] + " = " + str(dataSpring[dataNumber]);
  }else{
    if(keySwitch.released(mouseX, mouseY)) KetaiKeyboard.toggle(this);
    else if(buttonMenu.released(mouseX, mouseY)) page_number = 0;
    else if(buttonCalc.released(mouseX, mouseY)) page_number = 1;
    else if(buttonData.released(mouseX, mouseY)) page_number = 2;
    else{
      if(page_number == 0){
        if(listSpringTypeButton.released(mouseX, mouseY-render_offset[page_number])){
          listSpringType = new KetaiList(this, listSpringTypeButton.list);
          numList = 0;
        }else if(listLangageTypeButton.released(mouseX, mouseY-render_offset[page_number])){
          listLangageType = new KetaiList(this, listLangageTypeButton.list);
          numList = 1;
        }
      }else if(page_number == 1){
        if(listMaterialSelection.released(mouseX, mouseY-render_offset[page_number])){
          listMaterial = new KetaiList(this, listMaterialSelection.list);
          numList = 2;
        }else{
          for(int i = 0; i < numData; i++){
            if(buttonDataInput[i].released(mouseX, mouseY-render_offset[page_number])){
              dataNumber = i;
              NKB.active = true;
              NKB.titleLabel = buttonDataInput[i].labelText;
              break;
            }
          }
        }
      }
      KetaiKeyboard.hide(this);
    }
    if(stored_offset[page_number]+mouseY-myMouseAction.initialY<0){
      render_offset[page_number] = stored_offset[page_number]+mouseY-myMouseAction.initialY;
    }else{
      render_offset[page_number] = 0;
    }
    stored_offset[page_number] = render_offset[page_number];
  }
  //END OF NONE NUMBER KYEBOARD CONDITION
}

//---------------------------------------------------------------------------------------------------MOUSE DRAGGED FUNCTION
void mouseDragged(){
  android.view.MotionEvent me = (MotionEvent) mouseEvent.getNative();
  if(stored_offset[page_number] + mouseY - myMouseAction.initialY < 0){
    render_offset[page_number] = stored_offset[page_number] + mouseY - myMouseAction.initialY;
  }else{
   render_offset[page_number] = 0;
  }
  if(myMouseAction.getDistance() > 300.0f){
    if(NKB.active){
    }else{
      keySwitch.isButtonPressed = false;;
      buttonMenu.isButtonPressed = false;
      buttonCalc.isButtonPressed = false;
      buttonData.isButtonPressed = false;
      if(page_number == 0){
        listSpringTypeButton.isButtonPressed = false;
        listLangageTypeButton.isButtonPressed = false;
      }else if(page_number == 1){
        listMaterialSelection.isButtonPressed = false;
        for(int i = 0; i < numData; i++) buttonDataInput[i].isButtonPressed = false;
      }
      KetaiKeyboard.hide(this);
    }
  }

  pssr = me.getPressure();
  mx = me.getX();
  my = me.getY();
  
  switch(me.getActionMasked()){
    case MotionEvent.ACTION_DOWN:
      event_type = "action down!";
      break;
    case MotionEvent.ACTION_UP:
      event_type = "action up!";
      break;
    case MotionEvent.ACTION_MOVE:
      event_type = "action move!!";
      break;
    default:
      event_type = "NONE";
      break;
  }
}

void keyPressed(){
  key_input += str(key);
  println(key);
}

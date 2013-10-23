import ketai.ui.*;
import android.view.MotionEvent;

springProperty SP;
numberKeyboard NKB;
mouseAction MA;

String str_count;
color colText;
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

int[] stored_offset;
int[] render_offset;

int page_number;
int wipeRange;
int wipeOffset;
Boolean isWipe;
Boolean isControl;
Boolean isButtonDepression;

int numList;

KetaiList listMaterial;
materialButton listMaterialSelection;

int springType;
KetaiList listSpringType;
springTypeButton listSpringTypeButton;

int langageType;
KetaiList listLangageType;
langageTypeButton listLangageTypeButton;

Boolean isNewton;
KetaiList listUnitType;
unitTypeButton listUnitTypeButton;

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
  page_number = 1;
  wipeRange = int(width*0.3f);
  wipeOffset = 0;
  isWipe = false;
  isControl = false;
  isButtonDepression = false;
  main_font_size = 12;
  main_font = createFont("Meiryo", main_font_size);
  large_font_size = 24;
  large_font = createFont("Meiryo", large_font_size);
  textSize(main_font_size);
  textAlign(LEFT);
  strokeWeight(10);
  colText = color(250, 250, 250);
  indent_l = 10;
  buttonHeight = 48;
  align_h = buttonHeight + 2;
  noStroke();
  
  //----------------------------------------------------------------------------------MOUSE ACTION SET UP
  MA = new mouseAction();
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
  listLangageTypeButton = new langageTypeButton(indent_l, align_h*2, width-2*indent_l, buttonHeight, "言語");
  
  isNewton = false;
  listUnitTypeButton = new unitTypeButton(indent_l, align_h*3, width-2*indent_l, buttonHeight, "単位");
  
  //----------------------------------------------------------------------------------DATA INPUT BUTTONS
  springType = 0;
  listSpringTypeButton = new springTypeButton(indent_l, align_h*2, width-2*indent_l, buttonHeight, "バネの種類");
  listMaterialSelection = new materialButton(indent_l, align_h*3, width-2*indent_l, buttonHeight, "材質");
  numData = 9;
  dataSpring = new float[numData];
  buttonDataInput = new button[numData];
  buttonLabels = new String[numData];
  for(int i = 0; i < numData; i++){
    String buttonLabel = "";
    switch(i){
      case 0:
        dataSpring[i] = 1.0f;
        buttonLabels[i] = "コイル線径 = " + str(dataSpring[i]);
        break;
      case 1:
        dataSpring[i] = 5.0f;
        buttonLabels[i] = "平均径 = " + str(dataSpring[i]);
        break;
      case 2:
        dataSpring[i] = 10.0f;
        buttonLabels[i] = "巻数 = " + str(dataSpring[i]);
        break;
      case 3:
        dataSpring[i] = 10.0f;
        buttonLabels[i] = "有効巻数 = " + str(dataSpring[i]);
        break;
      case 4:
        buttonLabels[i] = "自由長";
        break;
      case 5:
        buttonLabels[i] = "第一荷重";
        break;
      case 6:
        dataSpring[i] = 21.0f;
        buttonLabels[i] = "第一荷重長 = " + str(dataSpring[i]);
        break;
      case 7:
        buttonLabels[i] = "第二荷重";
        break;
      case 8:
        dataSpring[i] = 15.0f;
        buttonLabels[i] = "第二荷重長 = " + str(dataSpring[i]);
        break;
      default:
        buttonLabels[i] = "NONE";
        break;
    }
    buttonDataInput[i] = new button(indent_l, align_h*(i+4), width-2*indent_l, buttonHeight, buttonLabels[i]);
  }
  dataNumber = 0;
  
  NKB = new numberKeyboard(width, height);
  NKB.active = false;
  
  SP = new springProperty();
  
  println(PFont.list());
}

//--------------------------------------------------------------------------------------------RENDER(DRAW) PAGES
void drawPage0(){
  pushMatrix();
  translate(0, render_offset[0]);
  listLangageTypeButton.render();
  listUnitTypeButton.render();
  popMatrix();
}

void drawPage1(){
  pushMatrix();
  translate(0, render_offset[1]);
  listSpringTypeButton.render();
  listMaterialSelection.render();
  for(int i = 0; i < numData; i++) buttonDataInput[i].render();
  popMatrix();
}

void drawPage2(){
  pushMatrix();
  translate(0, render_offset[2]);
  textFont(main_font);
  fill(10, 10, 10);
  SP.render();
  popMatrix();
}
  
  
//--------------------------------------------------------------------------------------------DRAW FUNCTION
void draw(){
  background(255, 255, 255);
  //image(bg_image, 0, 0, width, height);
  if(isWipe){
    int page_add = 0;
    //--------------------------------------------------------------WIPE ACTION UNDER THE USER CONTROL.
    if(isControl) wipeOffset = MA.dX();
    //-------------------------------------------------------------WIPE ACTION WITHOUT ANY USER CONTROL.
    else{
      float c = 0.6f;//-----------------------------ACTION PARAMETER.
      if(abs(wipeOffset) > wipeRange){
        if(wipeOffset > 0) wipeOffset = width - int((width - wipeOffset)*c);
        else wipeOffset = int((width+wipeOffset)*c) - width;
        if(width - abs(wipeOffset) < 10){
          isWipe = false;
          if(wipeOffset > 0 && page_number > 0) page_add = -1;
          else if(wipeOffset < 0 && page_number < 2) page_add = 1;
        }
      }else{
        wipeOffset = int(wipeOffset*c);
        if(abs(wipeOffset) < 10) isWipe = false;
      }
      //------------------------------------END OF WIPE ACTION.
      if(!isWipe){
        page_number += page_add;
        wipeOffset = 0;
      }
    }
  }
    
  if(NKB.active == false){
    //-----------------------------------------------CONDITIONAL BRANCH OF PAGE NUMBER
    //-----------------------------------------STATIC PAGE RENDERING.
    if(!isWipe){
      if(page_number == 0) drawPage0();
      else if(page_number == 1) drawPage1();
      else if(page_number == 2) drawPage2();
    }
    //----------------------------------DINAMIC PAGE RENDERING(WIPE ACTION).
    else{
      pushMatrix();
      translate(wipeOffset-width*page_number, 0);
      drawPage0();
      translate(width, 0);
      drawPage1();
      translate(width, 0);
      drawPage2();
      popMatrix();
    }
    //---------------------------------------------END OF CONDITIONAL BRANCH OF PAGE NUMBER
    //------------------------------------------------------HEADER MENU RENDERING
    fill(0, 0, 0, 100);
    rect(0, 0, width, buttonHeight*2);
    fill(colText);
    textFont(large_font);
    //textSize(large_font_size);
    text("E.N.SPRING", indent_l, align_h+large_font_size);
    textFont(main_font);
    text("the engineering notes for spring calculation.", indent_l, align_h+large_font_size+main_font_size+2);
    buttonMenu.render();
    buttonCalc.render();
    buttonData.render();
    //------------------------END OF HEADER MENU RENDERING
  }else if(NKB.active){
    NKB.render();
  }
  
  //--------------------------------------------------------------DEBUG INFO WRITING.
  textFont(main_font);
  fill(150, 0, 200);
  pushMatrix();
  translate(width*0.5f, 0);
  if(isWipe) text("WIPING!", indent_l, 100);
  else text("NO WIPE", indent_l, 100);
  text("WIPEOFFSET: "+wipeOffset, indent_l, 130);
  text("PAGE No. "+page_number, indent_l, 160);
  popMatrix();
  
}

//-----------------------------------------------------------------------------------------------------Ketai LIST SELECTION
void onKetaiListSelection(KetaiList klist){
  String selected = klist.getSelection();
  if(numList == 0) springType = listSpringTypeButton.getConstant(selected);
  else if(numList == 1) langageType = listLangageTypeButton.getConstant(selected);
  else if(numList == 2) isNewton = listUnitTypeButton.getConstant(selected);
  else if(numList == 10){
    SP.G = listMaterialSelection.getConstant(selected);
    SP.material = selected;
  }
}

//----------------------------------------------------------------------------------------------------MOUSE PRESSED FUNCTION
void mousePressed(){
  MA.pressed();
  isButtonDepression = false;
  if(NKB.active){
    NKB.buttonPressed(mouseX, mouseY);
  }else{
    buttonMenu.pressed(mouseX, mouseY);
    buttonCalc.pressed(mouseX, mouseY);
    buttonData.pressed(mouseX, mouseY);
    //----------------------------------------------------------------"mos" MEANS Mouse Offset.
    int mosY = mouseY - render_offset[page_number];
    if(page_number == 0){
      listLangageTypeButton.pressed(mouseX, mosY);
      listUnitTypeButton.pressed(mouseX, mosY);
    }else if(page_number == 1){
      listSpringTypeButton.pressed(mouseX, mosY);
      listMaterialSelection.pressed(mouseX, mosY);
      for(int i = 0; i < numData; i++) buttonDataInput[i].pressed(mouseX, mosY);
    }
  }
}

//-----------------------------------------------------------------------------------------------------MOUSE RELEASED FUNCTION
void mouseReleased(){
  if(NKB.active){
    dataSpring[dataNumber] = NKB.buttonReleased(mouseX, mouseY);
    buttonDataInput[dataNumber].labelText = buttonLabels[dataNumber] + " = " + str(dataSpring[dataNumber]);
  }else{
    if(buttonMenu.released(mouseX, mouseY)) page_number = 0;
    else if(buttonCalc.released(mouseX, mouseY)) page_number = 1;
    else if(buttonData.released(mouseX, mouseY)){
      SP.setVariables(dataSpring);
      SP.run(springType);
      page_number = 2;
    }else{
      switch(page_number){
        case 0:
          if(listLangageTypeButton.released(mouseX, mouseY-render_offset[page_number])){
            listLangageType = new KetaiList(this, listLangageTypeButton.list);
            numList = 1;
          }else if(listUnitTypeButton.released(mouseX, mouseY-render_offset[page_number])){
            listUnitType = new KetaiList(this, listUnitTypeButton.list);
            numList = 2;
          }
          break;
        case 1:
          if(listSpringTypeButton.released(mouseX, mouseY-render_offset[page_number])){
            listSpringType = new KetaiList(this, listSpringTypeButton.list);
            numList = 0;
          }else if(listMaterialSelection.released(mouseX, mouseY-render_offset[page_number])){
            listMaterial = new KetaiList(this, listMaterialSelection.list);
            numList = 10;
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
          break;
      }
    }
  }
  //-----------------------------------------------------------------------WIPE CONTROL Y FINISHED.
  if(stored_offset[page_number]+ MA.dY() <0){
    render_offset[page_number] = stored_offset[page_number]+ MA.dY();
  }else{
    render_offset[page_number] = 0;
  }
  stored_offset[page_number] = render_offset[page_number];
  //------------------------------------------------------------------WIPE CONTROL X FINISHED( ** USER CONTROL FLAG ** ).
  isControl = false;
  //-----------------------------------------------------------------------------------------------END OF NONE NUMBER KYEBOARD CONDITION
}

//---------------------------------------------------------------------------------------------------MOUSE DRAGGED FUNCTION
void mouseDragged(){
  android.view.MotionEvent me = (MotionEvent) mouseEvent.getNative();
  //----------------------------------------------------------------------WIPE(TOUCH) ACTION CONTROL.
  if(!NKB.active && !isWipe){
    if(abs(MA.dX()) > abs(MA.dY())){
      isWipe = true;
      isControl = true;
    }else{
      isControl = false;
      if(stored_offset[page_number] + MA.dY() < 0){
        render_offset[page_number] = stored_offset[page_number] + MA.dY();
      }else{
       render_offset[page_number] = 0;
      }
    }
  }
  //---------------------------------------------------------------------INACTIVATE BUTTON READY STATUS.
  if(MA.getDistance() > wipeRange && isButtonDepression == false){
    isButtonDepression = true;
    if(NKB.active){
    }else{
      buttonMenu.isButtonPressed = false;
      buttonCalc.isButtonPressed = false;
      buttonData.isButtonPressed = false;
      if(page_number == 0){
        listLangageTypeButton.isButtonPressed = false;
        listUnitTypeButton.isButtonPressed = false;
      }else if(page_number == 1){
        listSpringTypeButton.isButtonPressed = false;
        listMaterialSelection.isButtonPressed = false;
        for(int i = 0; i < numData; i++) buttonDataInput[i].isButtonPressed = false;
      }
    }
  }
}

void keyPressed(){
  println(key);
}

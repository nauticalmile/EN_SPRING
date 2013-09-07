import ketai.ui.*;
import android.view.MotionEvent;

String str_count;
color colText;
int indent_l;
int indent_h;
int align_h;
int buttonHeight;
PImage bg_image;
PFont main_font;

int numList;
//0:material
//1: diameter of wire
//2: diameter of coil
//3: number of loop
//4: free length
//5: first force
//6: first length of use
//7: second force
//8: second length of use

String str_w, str_h;
String event_type;
String key_input;
float mx, my;
float pssr;
button keySwitch;
float constant;

KetaiList listMaterial;
materialButton listMaterialSelection;

int numData;
int dataNumber;
button[] buttonDataInput;
String[] buttonLabels;
float[] dataSpring;


numberKeyboard NKB;


void setup(){
  println("SET UP EN_SPRING");
  orientation(PORTRAIT);
  frameRate(30);
  bg_image = loadImage("bg.jpg");
  main_font = loadFont("Meiryo-12.vlw");
  textSize(26);
  textAlign(LEFT);
  strokeWeight(10);
  colText = color(250, 250, 250);
  indent_l = 10;
  buttonHeight = 33;
  align_h = buttonHeight + 2;
  event_type = "NONE";
  pssr = 0;
  mx = 0;
  my = 0;
  noStroke();
  key_input = "a";
  keySwitch = new button(indent_l, align_h, width-2*indent_l, buttonHeight, "keyboard");
  
  listMaterialSelection = new materialButton(indent_l, align_h*2, width-2*indent_l, buttonHeight, "material");
  
  numData = 8;
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
        buttonLabels[i] = "Diameter of Coil";
        break;
      case 2:
        buttonLabels[i] = "Number of Loop";
        break;
      case 3:
        buttonLabels[i] = "Number of Invalid Loop";
        break;
      default:
        buttonLabels[i] = "None";
        break;
    }
    buttonDataInput[i] = new button(indent_l, align_h*(i+3), width-2*indent_l, 30, buttonLabels[i]);
  }
  dataNumber = 0;
  
  NKB = new numberKeyboard(width, height);
  NKB.active = false;
  
  println(PFont.list());
}

void draw(){
  background(255, 255, 255);
  image(bg_image, 0, 0, width, height);
  if(NKB.active == false){
  fill(colText);
  textFont(main_font);
  textSize(24);
  text("E.N.SPRING", indent_l, 30);
  textSize(12);
  indent_h = 250;
  for(int i = 0; i < 7; i++){
    indent_h += 30;
    if(i==0) text("engineers::notes", indent_l, indent_h);
    if(i==1) text("Count=" + str(frameCount), indent_l, indent_h);
    if(i==2) text("w=" + str(width) + ", h=" + str(height), indent_l, indent_h);
    if(i==3) text("TOUCH: " + event_type, indent_l, indent_h);
    if(i==4) text(key_input , indent_l, indent_h);
    if(i==5) text("X=" + str(mx) + ", Y=" + str(my) + ", P=" + str(pssr), indent_l, indent_h);
    if(i==6) text(key_input, indent_l, indent_h);
  }
  
  keySwitch.render();
  listMaterialSelection.render();
  for(int i = 0; i < numData; i++) buttonDataInput[i].render();
  
  }else if(NKB.active) NKB.render();
}

void onKetaiListSelection(KetaiList klist){
  String selected = klist.getSelection();
  if(numList == 0){
    constant = listMaterialSelection.getConst(selected);
  }
}

void mousePressed(){
  if(NKB.active){
    dataSpring[dataNumber] = NKB.buttonPressed(mouseX, mouseY);
    buttonDataInput[dataNumber].labelText = buttonLabels[dataNumber] + " = " + str(dataSpring[dataNumber]);
  }else{
    if(keySwitch.judge(mouseX, mouseY)){
      KetaiKeyboard.toggle(this);
    }else if(listMaterialSelection.judge(mouseX, mouseY)){
      listMaterial = new KetaiList(this, listMaterialSelection.list);
    }else{
      for(int i = 0; i < numData; i++){
        if(buttonDataInput[i].judge(mouseX, mouseY)){
          dataNumber = i;
          NKB.active = true;
          break;
        }
      }
      KetaiKeyboard.hide(this);
    }
  }
}

void mouseReleased(){

}
void mouseDragged(){
  android.view.MotionEvent me = (MotionEvent) mouseEvent.getNative();
  
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

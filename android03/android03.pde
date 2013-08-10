import ketai.ui.*;
import android.view.MotionEvent;

String str_count;
color colText;
int indent_l;
int indent_h;
int allign_h;
int numList;
//0:material
//1:diameter
//2:number
String str_w, str_h;
String event_type;
String key_input;
float mx, my;
float pssr;
button keySwitch;
float constant;

KetaiList listMaterial;
materialButton listMaterialSelection;

KetaiList listNumber;
numericButton listNumberSelection;

numberKeyboard NKB;


void setup(){
  orientation(PORTRAIT);
  textSize(24);
  textAlign(LEFT);
  strokeWeight(10);
  colText = color(50, 50, 50);
  indent_l = 30;
  allign_h = 50;
  event_type = "NONE";
  pssr = 0;
  mx = 0;
  my = 0;
  noStroke();
  key_input = "a";
  keySwitch = new button(indent_l, allign_h, width-2*indent_l, 30, "keyboard");
  
  listMaterialSelection = new materialButton(indent_l, allign_h*2, width-2*indent_l, 30, "material");
  listNumberSelection = new numericButton(indent_l, allign_h*4, width-2*indent_l, 30, "number");
  
  NKB = new numberKeyboard(width, height);
}

void draw(){
  background(255, 255, 255);
  fill(colText);
  textSize(24);
  text("EN;SPRING CALCULATOR", indent_l, 30);
  textSize(12);
  indent_h = 100;
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
  listNumberSelection.render();
  
  NKB.render();
}

void onKetaiListSelection(KetaiList klist){
  String selected = klist.getSelection();
  if(numList == 0){
    constant = listMaterialSelection.getConst(selected);
  }else if(numList == 2){
    int value = listNumberSelection.getValue(selected);
  }
}

void mousePressed(){
  if(keySwitch.judge(mouseX, mouseY)){
    KetaiKeyboard.toggle(this);
  }else if(listMaterialSelection.judge(mouseX, mouseY)){
    listMaterial = new KetaiList(this, listMaterialSelection.list);
    numList = 0;
  }else if(listNumberSelection.judge(mouseX, mouseY)){
    listNumber = new KetaiList(this, listNumberSelection.list);
    numList = 2;
  }else{
    KetaiKeyboard.hide(this);
  }
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
  }
}

void keyPressed(){
  key_input += str(key);
  println(key);
}

class springTypeButton extends button{
  //-----MEMBERS----------------------------------------------------------
  ArrayList<String> list;
  
  //-----METHODS----------------------------------------------------------
  springTypeButton(int pos_x, int pos_y, int size_x, int size_y, String label){
    super(pos_x, pos_y, size_x, size_y, label);
    list = new ArrayList<String>();
    list.add("圧縮ばね");
    list.add("引張りばね");
    list.add("ねじりばね");
  }
  
  int getConstant(String springType){
    labelText = "バネの種類 = " + springType;
    if(springType == "圧縮ばね") return 0;
    else if(springType == "引っ張りばね")return 1;
    else if(springType == "ねじりばね") return 2;
    else return -1;
  }
}

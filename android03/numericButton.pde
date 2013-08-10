class numericButton extends button{
  //-----MEMBERS----------------------------------------------------------
  ArrayList<String> list;
  
  //-----METHODS----------------------------------------------------------
  numericButton(int pos_x, int pos_y, int size_x, int size_y, String label){
    super(pos_x, pos_y, 16, size_y, "0");
    list = new ArrayList<String>();
    list.add("0");
    list.add("1");
    list.add("2");
    list.add("3");
    list.add("4");
    list.add("5");
    list.add("6");
    list.add("7");
    list.add("8");
    list.add("9");
  }
  
  int getValue(String number){
    labelText = number;
    return int(number);
  }
}

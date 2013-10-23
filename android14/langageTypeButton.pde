class langageTypeButton extends button{
  //-----MEMBERS----------------------------------------------------------
  ArrayList<String> list;
  
  //-----METHODS----------------------------------------------------------
  langageTypeButton(int pos_x, int pos_y, int size_x, int size_y, String label){
    super(pos_x, pos_y, size_x, size_y, label);
    list = new ArrayList<String>();
    list.add("日本語");
    list.add("英語");
  }
  
  int getConstant(String langageType){
    labelText = "言語 = " + langageType;
    if(langageType == "英語") return 0;
    else if(langageType == "日本語")return 1;
    else return -1;
  }
}

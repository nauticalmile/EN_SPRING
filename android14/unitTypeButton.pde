class unitTypeButton extends button{
  //-----MEMBERS----------------------------------------------------------
  ArrayList<String> list;
  
  //-----METHODS----------------------------------------------------------
  unitTypeButton(int pos_x, int pos_y, int size_x, int size_y, String label){
    super(pos_x, pos_y, size_x, size_y, label);
    list = new ArrayList<String>();
    list.add("N");
    list.add("kgf");
  }
  
  Boolean getConstant(String langageType){
    labelText = "単位 = " + langageType;
    if(langageType == "N") return true;
    else if(langageType == "kgf")return false;
    else return false;
  }
}

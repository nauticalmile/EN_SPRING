class materialButton extends button{
  //-----MEMBERS----------------------------------------------------------
  ArrayList<String> list;
  
  //-----METHODS----------------------------------------------------------
  materialButton(int pos_x, int pos_y, int size_x, int size_y, String label){
    super(pos_x, pos_y, size_x, size_y, label);
    list = new ArrayList<String>();
    list.add("SUS304WPB");
    list.add("SUS302");
    list.add("SWP-A");
    list.add("SWP-B");
    list.add("SWB");
    list.add("SWC");
    list.add("SUS316WPA");
  }
  
  float getConstant(String material){
    labelText = "材質 = " + material;
    if(material == "SUS304WPB") return 7000.0f;
    else if(material == "SUS302")return 7000.0f;
    else return 1000.0f;
  }
}

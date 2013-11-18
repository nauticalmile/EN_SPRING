class materialButton extends button{
  //-----MEMBERS----------------------------------------------------------
  ArrayList<String> list;
  
  //-----METHODS----------------------------------------------------------
  materialButton(int pos_x, int pos_y, int size_x, int size_y, String label){
    super(pos_x, pos_y, size_x, size_y, label);
    list = new ArrayList<String>();
    list.add("SUS304WPB");
    list.add("SUS302");
    list.add("SUS316");
    list.add("SUS631J1");
    list.add("SW-B");
    list.add("SW-C");
    list.add("SWP");
    list.add("SWO");
    list.add("SUP");
  }
  
  float getConstant(String material){
    labelText = "材質 = " + material;
    if(material == "SUS304WPB") return 7000.0f;
    else if(material == "SUS302")return 7000.0f;
    else if(material == "SUS316") return 7000.0f;
    else if(material == "SUS631J1") return 7500.0f;
    else if(material == "SW-B")return 8000.0f;
    else if(material == "SW-C") return 8000.0f;
    else if(material == "SWP") return 8000.0f;
    else if(material == "SWO") return 8000.0f;
    else if(material == "SUP") return 8000.0f;
    else return 1000.0f;
  }
}

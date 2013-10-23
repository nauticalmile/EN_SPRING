//-------------------------------------------------------------------------------------WRITTEN BY nauticalmile
//---------------------------------------------------------------------------------------------------------

class springProperty{
  //-----MEMBERS-------------------------------------------------------------------------------MEMBERS
  int springType;
  String material;
  float d;//---------------線径
  float oD;//--------------外径
  float D;//---------------平均径
  float iD;//--------------内径
  float Nt;//--------------総巻き数
  float Na;//--------------有効巻き数
  float Nb;//---------------座巻き数
  float L;//--------------自由高さ
  float Hs;//-------------密着高さ
  float p;//--------------ピッチ
  float Pl;//-------------初張力
  float c;//--------------ばね指数
  float G;//---------------横弾性係数
  float P;//---------------バネにかかる荷重
  float delta;//-----------バネのたわみ
  float k;//---------------バネ定数
  float tau0;//------------ねじり応力
  float tau;//-------------ねじり修正応力
  float taui;//------------初応力
  float X;//---------------応力修正係数
  float f;//---------------振動数
  float U;//---------------バネに蓄えられるエネルギー
  float omega;//-----------材料の単位体積当たりの質量
  float W;//---------------バネの運動部分の質量
  float g;//---------------重力加速度
  float H1;//--------------取り付け高さ(第一荷重高さ)
  float P1;//--------------取り付け荷重(第一荷重)
  float t1;//--------------応力１
  float H2;//--------------使用高さ(第二荷重高さ)
  float P2;//--------------使用荷重(第二荷重高さ)
  float t2;//--------------応力２
  
  
  //-------------------------------------------------------------------------------------------METHODS
  //--------------------------------------------------------------------------------CONSTRUCTOR
  springProperty(){
    springType = 0;
    d = 0.0f;//---------------線径
    oD = 0.0f;//--------------外径
    D = 0.0f;
    iD = 0.0f;
    Na = 0.0f;
    Nb = 0.0f;
    L = 0.0f;
    Hs = 0.f;
    p = 0.0f;
    Pl = 0.0f;
    c = 0.0f;
    G = 0.0f;
    P = 0.0f;
    delta = 0.0f;
    k = 0.0f;
    tau0 = 0.0f;
    tau = 0.0f;
    taui = 0.0f;
    X = 0.0f;
    f = 0.0f;
    U = 0.0f;
    omega = 0.0f;
    W = 0.0f;
    g = 9.8f;
    H1 = 0.0f;
    P1 = 0.0f;
    t1 = 0.0f;
    H2 = 0.0f;
    P2 = 0.0f;
    t1 = 0.0f;
}
  
  //RENDERER FUNCTION------------------------------------------------------------RENDER FUNCTION
  void render(){
    int indent_h = 100;
    int indent_l = 20;
    for(int i = 0; i < 20; i++){
      indent_h += 30;
      if(i==0) text("SPRING PROPERTIES", indent_l, indent_h);
      else if(i==1) text("材質："+material, indent_l, indent_h);
      else if(i==2) write("横弾性係数", SP.G, "kgf/mm^2", indent_l, indent_h);
      else if(i==3) write("応力修正係数", SP.X, "--", indent_l, indent_h);
      
      else if(i==5) write("内径", SP.iD, "mm", indent_l, indent_h);
      else if(i==6) write("平均径", SP.D, "mm", indent_l, indent_h);
      else if(i==7) write("外径", SP.oD, "mm", indent_l, indent_h);
      
      else if(i==9) write("自由長", SP.L, "mm", indent_l, indent_h);
      else if(i==10) write("バネ定数", SP.k, "kgf/mm", indent_l, indent_h);
      else if(i==11) write("バネ指数", SP.c, "--", indent_l, indent_h);
      
      else if(i==13) write("第一加重", SP.P1, "kgf", indent_l, indent_h);
      else if(i==14) write("第一荷重長", SP.H1, "mm", indent_l, indent_h);
      else if(i==15) write("ねじり応力１", SP.t1, "kgf/mm", indent_l, indent_h);
      else if(i==16) write("ねじり修正応力１", SP.t1*SP.X, "kgf/mm", indent_l, indent_h);
      
      
    }

  }
  
  void write(String index, float value, String unit, int indent, int row){
    text(index+" : "+value+"["+unit+"]", indent, row);
  }
  
  void setVariables(float[] data){
    d = data[0];
    D = data[1];
    Nt = data[2];
    Na = data[3];
    L = data[4];
    P1 = data[5];
    H1 = data[6];
    P2 = data[7];
    H2 = data[8];
  }
  
  //--------------------------------------------------------------------------RUN THE CALCULATION
  Boolean run(int springTypeRequest){
    springType = springTypeRequest;
    //１：圧縮ばね
    //２：引張ばね
    //３：ねじりばね
    
    //除算安全性確認(ゼロで割るのを防ぐ)
    if(d*D*Na != 0){
      
      //コイル径計算
      oD = D + d;
      iD = D - d;
      
      //バネ指数計算
      if(d != 0.0f) c = D/d;
      
      //バネ定数計算
      if(D != 0.0f && Na != 0.0f) k = (G*d*d*d*d)/(8*Na*D*D*D);
      
      //巻き数調整
      switch(springType){
        case 0:
        Nt = Na + 2;
        case 1:
        Nt = Na;
        case 2:
        Nt = Na;
      }
      
      //応力計算
      t1 = 8*D*P1/(PI*d*d*d);
      t2 = 8*D*P2/(PI*d*d*d);
      
      //応力修正係数計算
      if(c != 0.0f) X = (4*c-1)/(4*c-4)+0.615/c;
      
      //自由長計算
      Hs = (Nt-1)*d;
      
      
    }
    return true;
  }
  
}
    
    
    

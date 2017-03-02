int index(int h) {
  if (h >= 9) {
    if (h < 11) return 0;
    return h - 10;
  }
  if (h > 18) day = (cal.get(Calendar.DAY_OF_WEEK)+5)%7;
  return 0;
}




void setInfo(String lezione) {
  if (lezione.equals("_") || lezione.equals(""))return;
  else if (lezione.equals("Pranzo")) {
    return;
  }
  String tmp[] = split(lezione,":");
  tmp[1]=trim(tmp[1]);
  aula = aule.findRow(tmp[1],"Nome");
  materia = materie.findRow(tmp[0],"Nome");
  scene = "info";
  imgInfo = getImgInfo(tmp[1]);
  //getColumnCount();
}

PImage[] getImgInfo(String name){
   PImage[] x = new PImage[4];
   for(int i=0; i < x.length; x[i]=loadImage(name+""+i+++".png"));
   return x;
}
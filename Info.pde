void printInfo() {
  /*
    Stampa le informazioni della materia cliccata 
   */
  textAlign(LEFT);
  image(imgInfo[imgIndex], 10, 10, 340, 250); 
  int mL = materia.getColumnCount();
  for (int i = 0; i < mL; i++) {
    String infoMateria = materia.getString(i);
    text(MATERIA[i]+infoMateria, 10, 300+50*i);
  }
  if ((second()%4==0 && frameCount%60==0)) {
    imgIndex = (imgIndex+1)%imgInfo.length;
  }
  textAlign(CENTER, CENTER);
  text("Indietro", 0, 600, 360, 40);
}

void printPranzo(){
 /*
   Stampa le informazioni relative ai locali dove mangiare vicino all'università
 */ 
}


void printCorso() {
  /*
    Stampa le scelte del corso (A o B)
   */
  background(255);
  stroke(0);
  fill((x >= 20 && x <= 340 && y >= 10 && y <= 310 && mousePressed) ? color(0, 100, 0):color(0, 200, 0));
  rect(20, 10, 320, 300);
  fill((x >= 20 && x <= 340 && y >= 330 && y <= 630 && mousePressed) ? color(100, 0, 0): color(200, 0, 0));
  rect(20, 330, 320, 300);
  textSize(40);
  fill(0);
  text("Corso A", 20, 10, 320, 300);
  text("Corso B", 20, 330, 320, 300);
}

void printAnno() {
  /*
    Stampa le possibili scelte degli anni
   */
  background(255);
  fill((x >= 10 && x <= 170 && y >= 20 && y <= 320 && mousePressed) ?color(200, 200, 0): color(255, 255, 0)); //Anno 1
  rect(10, 20, 160, 300);
  fill((x >= 190 && x <= 350 && y >= 20 && y <= 320 && mousePressed) ? color(200, 200, 0) : color(255, 255, 0) ); //Anno 2
  rect(190, 20, 160, 300);
  fill((x >= 10 && x <= 350 && y >= 340 && y <= 430 && mousePressed) ?  color(150, 150, 0) : color(200, 200, 0)); //Sistemi e Reti
  rect(10, 340, 340, 90); 
  fill((x >= 10 && x <= 350 && y >= 440 && y <= 530 && mousePressed) ?  color(200, 100, 0) : color(250, 160, 0)); //Linguaggi e Sistemi
  rect(10, 440, 340, 90); 
  fill((x >= 10 && x <= 350 && y >= 540 && y <= 630 && mousePressed) ?  color(150, 0, 0) : color(200, 0, 0)); //Informazione e Conoscenza
  rect(10, 540, 340, 90);

  fill(0);
  textSize(35);
  text("Anno 1", 10, 20, 160, 300);
  text("Anno 2", 190, 20, 160, 300);
  textSize(20);
  text("Sistemi e Reti", 10, 340, 340, 90);
  text("Linguaggi e Sistemi", 10, 440, 340, 90);
  text("Informazione e Conoscenza", 10, 540, 340, 90);
}

void printMatricola() {
  /*
    Stampa la selezione di matricola Pari o Displari
   */
  background(255);
  fill((x >= 20 && x <= 340 && y >= 10 && y <= 310 && mousePressed) ? color(0, 100, 0) : color(0, 200, 0));
  rect(20, 10, 320, 300);
  fill((x >= 20 && x <= 340 && y >= 330 && y <= 630 && mousePressed) ? color(100, 0, 0) : color(200, 0, 0));
  rect(20, 330, 320, 300);
  textSize(40);
  fill(0);
  text("Matricola Pari", 20, 10, 320, 300);
  text("Matricola Dispari", 20, 330, 320, 300);
}

void setInfo(String lezione) {
  if (lezione.equals("_") || lezione.equals(""))return;
  else if (lezione.equals("Pranzo")) {
    return;
  }
  String tmp[] = split(lezione, ":");
  tmp[1]=trim(tmp[1]);
  materia = materie.findRow(tmp[0], "Nome");
  scene = "info";
  imgInfo = getImgInfo(tmp[1]);
  //getColumnCount();
}

PImage[] getImgInfo(String name) {
  PImage[] x = new PImage[4];
  for (int i=0; i < x.length; x[i]=loadImage(name+""+i+++".png"));
  return x;
}
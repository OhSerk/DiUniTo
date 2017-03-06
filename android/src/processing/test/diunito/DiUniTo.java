package processing.test.diunito;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Calendar; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DiUniTo extends PApplet {


boolean rel=false;
int week, day;
int sem, anno, percorso, MATRICOLA;
char corso=' ';
String scene="Orario";
int turno, imgIndex=0;
float x, y;
Table materie, pranzo;
TableRow materia;
PImage[] imgInfo = new PImage[4];
final String[] settimana = {"Lun", "Mar", "Mer", "Gio", "Ven"}, 
  MATERIA={"Nome corso:", "Crediti:", "Modalit\u00e0 d'esame:", "Docente:", "Docente:", "Docente:"};
Calendar cal;
public void settings() {
  //fullScreen(); //Android
  size(360, 640); //Windows
}
Settimana a;
public void setup() {
  cal = Calendar.getInstance();
  day = (cal.get(Calendar.DAY_OF_WEEK)+5)%7; //Luned\u00ec = 0 .. Domenica = 6
  week = (cal.get(Calendar.WEEK_OF_YEAR)+1)%2; //Calcolo della settimana
  textAlign(CENTER, CENTER);
  if (month() >= 1 && month() < 8) { //Tra Gennaio e Luglio
    sem = 2;
  } else {
    sem = 1;
  }
  File x = new File(dataPath("Config.txt")); //File di configurazione
  if (x.exists()) {
    textSize(12);
    scene = "Orario"; 
    String[] tmp = loadStrings(dataPath("Config.txt"));
    corso = tmp[0].charAt(0);
    anno = PApplet.parseInt(tmp[1]);
    percorso = PApplet.parseInt(tmp[2]);
    MATRICOLA = PApplet.parseInt(tmp[3]);
    turno = PApplet.parseInt(tmp[4]);
    a = new Settimana(corso, anno, percorso, sem, turno);
    println(day, week);
  } else {
    scene = "Corso";
    corso = ' ';
    anno = 0;
    percorso= -1;
  }
}

public void draw() {
  background(200); //Colore sfondo
  x = mouseX/(width/360);
  y = mouseY/(height/640); //posizioni del mouse Scalati
  pushMatrix();
  scale(width/360, height/640); //Scalo tutto in 16:9
  if (scene.equals("Orario")) {
    a.view(); //STampo l'orario settimanale
    text("Cambia Orario", 0, 600, 360, 40);
  } else if (scene.equals("info")) {
    printInfo();
  } else if (scene.equals("Pranzo")) {
    printPranzo();
  } else if (scene.equals("Corso")) {
    printCorso();
  } else if (scene.equals("Anno")) {
    printAnno();
  } else if (scene.equals("Matricola")) {
    printMatricola();
  }
  popMatrix();
  rel = false;
}
public void mousePressed() {
}
public void keyPressed() {
  if (key=='d') day  =(day+1)%7;
  if (key=='w') week =(week+1)%2;
}
public void mouseReleased() {
  rel = true;
  if (scene.equals("Orario")) {
    orarioMR();
  } else if (scene.equals("info")) {
    infoMR();
  } else if(scene.equals("Pranzo")){
    pranzoMR();
  } else if (scene.equals("Corso")) {
    corsoMR();
  } else if (scene.equals("Anno")) {
    annoMR();
  } else if (scene.equals("Matricola")) {
    matricolaMR();
  }
}

public void orarioMR() {
  if (y >= 600 && y <= 640) {
    File x = new File(dataPath("Config.txt"));
    if (x.delete())
      setup();
  }
}

public void infoMR() {
  if (y >= 600 && y <= 640) {
    scene = "Orario";
    materia = null;
    textAlign(CENTER, CENTER);
  }
  if ((x >= 10 && y >= 10 && x <= 350 && y <= 210)) {
    imgIndex = (imgIndex+1)%imgInfo.length;
  }
}

public void pranzoMR() {
}

public void corsoMR() {
  if (x >= 20 && x <= 340 && y >= 330 && y <= 630) corso = 'B';
  if (x >= 20 && x <= 340 && y >= 10 && y <= 310) corso = 'A';
  if (corso != ' ') scene = "Anno";
}

public void annoMR() {
  if ((x >= 10 && x <= 170 && y >= 20 && y <= 320)) {//Anno 1
    anno=1;
    percorso=0;
  } 
  if ((x >= 190 && x <= 350 && y >= 20 && y <= 320)) {//Anno 2
    anno=2;
    percorso=0;
  } 
  if ((x >= 10 && x <= 350 && y >= 340 && y <= 430)) {//Sistemi e Reti
    anno=3;
    percorso=1;
  } 
  if ((x >= 10 && x <= 350 && y >= 440 && y <= 530)) {//Linguaggi e Sistemi
    anno=3;
    percorso=2;
  } 
  if ((x >= 10 && x <= 320 && y >= 540 && y <= 630)) {//Informazione e Conoscenza
    anno=3;
    percorso=3;
  } 
  if (anno != 0) scene = "Matricola";
}

public void matricolaMR() {
  if (x >= 10 && x <= 340 && y >= 330 && y <= 630) MATRICOLA = 1; //Displari
  if (x >= 10 && x <= 340 && y >= 10 && y <= 310) MATRICOLA = 0; //Pari
  if (MATRICOLA != -1) { 
    scene = "Orario";
    turno = ((MATRICOLA+1)%2+1) + (corso == 'A' ? 0 : 2);
    rel = false;
    a = new Settimana(corso, anno, percorso, sem, turno);
    stroke(0);
    fill(0);
    textSize(12);
    //salva
    salva(corso, anno, percorso, MATRICOLA, turno);
  }
}


public void salva(Object... o) {
  String[] save = new String[o.length];
  for (int i = 0; i < o.length; i++) {
    save[i] = o[i].toString();
  }
  saveStrings(dataPath("Config.txt"), save);
}
public void printInfo() {
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

public void printPranzo(){
 /*
   Stampa le informazioni relative ai locali dove mangiare vicino all'universit\u00e0
 */ 
}


public void printCorso() {
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

public void printAnno() {
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

public void printMatricola() {
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

public void setInfo(String lezione) {
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

public PImage[] getImgInfo(String name) {
  PImage[] x = new PImage[4];
  for (int i=0; i < x.length; x[i]=loadImage(name+""+i+++".png"));
  return x;
}
public class Settimana {
  Table table;
  Settimana(char corso, int anno, int percorso, int semestre, int turno) {
    String tabella = "";
    if (anno == 3)
      tabella = str(corso)+anno+"_"+percorso+"_"+semestre+"_"+week+".csv";
    else
      tabella = str(corso)+anno+"_"+semestre+"_"+week+"_"+turno+".csv";
    materie = loadTable(str(corso)+"Materie.csv", "header");
    table = loadTable(tabella, "header");
  }

  public void view() {
    int j = 0;
    for (TableRow row : table.rows()) {
      fill(150);
      rect(6, 10+65*j, 38, 65);
      fill(0);
      text((j+9)+"-"+(j+10), 6, 10+65*j, 38, 65);
      for (int i = 0; i < settimana.length; i++) {
        String lezione = row.getString(settimana[i]);
        if (j == hour()-9 && i == day) { 
          fill(0, 200, 0);
        } else {
          fill(255);
        }
        if (rel && x >= 44+62*i && x <= 106+62*i && y >= 10+65*j && y <= 75+70*j) {
          imgIndex=0;
          setInfo(lezione);
        }
        rect(44+62*i, 10+65*j, 62, 65);
        fill(0);
        text(lezione, 44+62*i, 10+65*j, 62, 65);
      }
      j++;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DiUniTo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

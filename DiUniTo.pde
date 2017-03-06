import java.util.Calendar;
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
  MATERIA={"Nome corso:", "Crediti:", "Modalità d'esame:", "Docente:", "Docente:", "Docente:"};
Calendar cal;
public void settings() {
  //fullScreen(); //Android
  size(360, 640); //Windows
}
Settimana a;
public void setup() {
  cal = Calendar.getInstance();
  day = (cal.get(Calendar.DAY_OF_WEEK)+5)%7; //Lunedì = 0 .. Domenica = 6
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
    anno = int(tmp[1]);
    percorso = int(tmp[2]);
    MATRICOLA = int(tmp[3]);
    turno = int(tmp[4]);
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

void orarioMR() {
  if (y >= 600 && y <= 640) {
    File x = new File(dataPath("Config.txt"));
    if (x.delete())
      setup();
  }
}

void infoMR() {
  if (y >= 600 && y <= 640) {
    scene = "Orario";
    materia = null;
    textAlign(CENTER, CENTER);
  }
  if ((x >= 10 && y >= 10 && x <= 350 && y <= 210)) {
    imgIndex = (imgIndex+1)%imgInfo.length;
  }
}

void pranzoMR() {
}

void corsoMR() {
  if (x >= 20 && x <= 340 && y >= 330 && y <= 630) corso = 'B';
  if (x >= 20 && x <= 340 && y >= 10 && y <= 310) corso = 'A';
  if (corso != ' ') scene = "Anno";
}

void annoMR() {
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

void matricolaMR() {
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


void salva(Object... o) {
  String[] save = new String[o.length];
  for (int i = 0; i < o.length; i++) {
    save[i] = o[i].toString();
  }
  saveStrings(dataPath("Config.txt"), save);
}
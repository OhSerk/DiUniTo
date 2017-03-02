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

  void view() {
    int j = 0;
    for (TableRow row : table.rows()) {
      for (int i = 0; i < settimana.length; i++) {
        String lezione = row.getString(settimana[i]);
        if (j == hour()-9 && i == day) { 
          fill(0, 200, 0);
        } else {
          fill(255);
        }
        if (rel && x >= 5+70*i && x <= 75+70*i && y >= 10+65*j && y <= 75+70*j) {
          setInfo(lezione);
        }
        rect(5+70*i, 10+65*j, 70, 65);
        fill(0);
        text(lezione, 5+70*i, 10+65*j, 70, 65);
      }
      j++;
    }
    //line(360, 0, 360, height);
    //line(0, 640, width, 640);
  }
}
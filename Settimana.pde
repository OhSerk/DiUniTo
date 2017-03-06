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
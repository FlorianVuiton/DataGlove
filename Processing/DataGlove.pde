import processing.serial.*;
Serial myPort;
int[] tab = new int[5];
Hand hand_player = new Hand();
Game jeu = new Game();

boolean playing = false;
boolean calibrating = false;
boolean shaking = false;
int cal_start_time = 0;

//TODO : 
//Probleme si on calibre avant de rentrer dans le draw_jeu ??

void setup() {
  size(1500, 900, P3D);
  myPort = new Serial(this, "COM8", 9600);  // Port BT
  myPort.bufferUntil ('\n');  // Retirer les résidus de début de connexion
}


void keyPressed() {
  if (keyPressed && key == 'c') {
    //Lancer la calibration
    hand_player.start_calibration();
  }
  if (keyPressed && key == 'j') {
    // Lancer le jeu
    playing = !playing;
  }
   if (keyPressed && key == ' ' && playing) {
    // Lancer la partie
    jeu.start_game();
  }
}


void draw() {

  // Récupérer les données du port BT
  if ( myPort.available() > 0) {  // If data is available,
    String serial_in = trim(myPort.readStringUntil('\n'));

    if (serial_in == null) {
      return;  // Quitte la fonction
    }

    // Décomposition de l'entree
    int debut = 0;
    int fin = 0;

    int indice_tab = 0;

    while ( indice_tab < 5 ) {
      debut = fin;
      fin = serial_in.indexOf(' ', debut + 1);
      if (fin != -1)
        tab[indice_tab] = int(trim(serial_in.substring(debut, fin)));
      else
        tab[indice_tab] = int(trim(serial_in.substring(debut)));

      indice_tab++;
    }
  }
  
  // Lier la valeur lu dans COM8 avec la hauteur des doigts
  hand_player.set_finger_heights(tab[0], tab[1], tab[2], tab[3], tab[4], true);

  if (calibrating)
    hand_player.draw_calibrate();
  else if (playing) {
    if (!shaking)
      jeu.draw_jeu();
    else
      jeu.draw_shake();  
  }
  else
    draw_demo();
}



void draw_demo() {
  background(100);

  if (!playing)
    camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  translate(width/2, height/2, -500);


  // Afficher la main de l'utilisateur (en bleu)
  hand_player.draw_hand(220, 220, 255);
}

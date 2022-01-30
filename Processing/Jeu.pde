

class Game {

  int score_player = 0;
  int score_com = 0;
  String move_player_str = "";
  String move_com_str = "";
  int player_move = -1;  // 1 : pierre, 2 : feuille, 3 : sciseaux. -1 : Non reconnu
  int com_move = -1; //1: pierre, 2 : feuille, 3 : sciseaux
  int shake_start_time =0;
  
  // Position de la main de l'ordi (en fonction de sont état)
  float [] rock = {1, 1, 1, 1, 1};
  float [] paper = {0, 0, 0, 0, 0};
  float [] scissors = {1, 1, 0, 0, 1};
  Hand hand_com;


  Game() {
    hand_com = new Hand();
  }


  void draw_jeu() {
    // TODO : pivoter les mains

    camera();  // Camera par defaut


    // Afficher la main de l'utilisateur
    translate(-width/3, 0, -200);
    draw_demo();
    translate(width/3, 0, 200);

    // Separateur
    translate(0, 0, -1);
    fill(255);
    box(30, height * 2, 10);
    translate(0, 0, 1);

    // Afficher la main de l'ordi
    pushMatrix();
    translate(width/3, 0, -200);

    if (com_move == 1) {
      hand_com.set_finger_heights(rock[0], rock[1], rock[2], rock[3], rock[4], false);
      move_com_str = "Pierre";
    } else if (com_move == 2) {
      hand_com.set_finger_heights(paper[0], paper[1], paper[2], paper[3], paper[4], false);
      move_com_str = "Feuille";
    } else if (com_move == 3) {
      hand_com.set_finger_heights(scissors[0], scissors[1], scissors[2], scissors[3], scissors[4], false);
      move_com_str = "Ciseaux";
    }
    
    hand_com.draw_hand(255, 210, 190);  // Main de l'ordinateur (en rouge)
    
    popMatrix(); //translate(-width/3, 0, 200);

    if (com_move != -1) {  // Donc on a joué au moins une fois
      fill(250);  // Texte blanc
      textSize(200);
      text(str(score_player), -width * 3 / 4, - height / 2 - 50);  // Score joueur
      text(str(score_com), width * 3 / 4 - 200, -height / 2 - 50);  // Score ordi
      
      textSize(75);
      text(move_player_str, -width * 2 / 3, height / 2 + 200);  // Move player
      text(move_com_str, width * 2 / 3 - 200, height / 2 + 200);  // Move ordi
    }
  }


  void draw_shake () {
    background(200);

    fill(0);  // Texte noir
    textSize(150);

    if (millis() - shake_start_time < 1000) {
      text("3", width/2 -50, height/2);
    } else if (millis() - shake_start_time < 2000) {
      text("2", width/2 - 50, height/2);
    } else if (millis() - shake_start_time < 3000) {
      text("1", width/2 -50, height/2);
    } else {
      shaking = false;
      read_player_move();
      check_for_winner();
    }
  }


  void start_game() {
    com_move = int(random(1, 4)); // Tirer un chiffre entre 1 et 3
    shake_start_time= millis();
    shaking = true;
  }


  void read_player_move() {
    // Trouver quelle formation le joueur joue

    float threshold = 0.4;  // Seuil a partir duquel un doight est considéré 'ouvert' ou 'fermé' 
    float fh1 = hand_player.get_finger(1).get_Hfactor();  // Index
    float fh2 = hand_player.get_finger(2).get_Hfactor();  // Majeur
    float fh3 = hand_player.get_finger(3).get_Hfactor();  // Doigt de la bague
    float fh4 = hand_player.get_finger(4).get_Hfactor();  // Petit doigt
    // On ignore le pouce car il n'est pas important
    if (fh1 > threshold && fh2 > threshold && fh3 > threshold && fh4 > threshold) {  // Pierre
      player_move = 1;
      move_player_str = "Pierre";
    } else if (fh1 < threshold && fh2 < threshold && fh3 < threshold && fh4 < threshold) {  // Feuille
      player_move = 2;
      move_player_str = "Feuille";
    } else if (fh1 > threshold && fh2 > threshold && fh3 < threshold && fh4 < threshold) {  // Sciseaux
      player_move = 3;
      move_player_str = "Ciseaux";
    } else {
      player_move = 4;
      move_player_str = "Position non reconnue"; 
    }
  }


  void check_for_winner() {
    if (player_move == com_move || player_move == 4) {
      // Egalité ou erreur, le score ne change pas
    }
    else if (player_move == 1 && com_move == 2 ||
      player_move == 2 && com_move == 3 ||
      player_move == 3 && com_move == 1) {  // Perdu
      score_com++;
    } else {  // Gagné
      score_player++;
    }
  }
}

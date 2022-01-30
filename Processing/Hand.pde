class Hand {
  Finger f1;
  Finger f2;
  Finger f3;
  Finger f4;
  Finger f5;

  Hand() {
    f1 = new Finger(-220, 0, false);
    f2 = new Finger(-110, 0, false);
    f3 = new Finger(0, 0, false);
    f4 = new Finger(110, 0, false);
    f5 = new Finger(220, 200, true);  // Pouce
  }

  Finger get_finger(int f) {
    switch (f) {
    case 1:
      return f1;
    case 2:
      return f2;
    case 3:
      return f3;
    case 4:
      return f4;
    default:
      return f5;
    }
  }

  void set_finger_heights(float h1, float h2, float h3, float h4, float h5, boolean choice_height) {
    if (choice_height) {
      f1.set_height(h1);
      f2.set_height(h2);
      f3.set_height(h3);
      f4.set_height(h4);
      f5.set_height(h5);
    } else {
      f1.set_Hfactor(h1);
      f2.set_Hfactor(h2);
      f3.set_Hfactor(h3);
      f4.set_Hfactor(h4);
      f5.set_Hfactor(h5);
    }
  }

  void draw_hand(int r, int g, int b) {

    stroke(0);
    strokeWeight(5);
    fill(r, g, b);

    f1.translateSegment();
    f2.translateSegment();
    f3.translateSegment();
    f4.translateSegment();
    f5.translateSegment();


    // Afficher la paume de la main
    translate(-55, 250);
    fill(r / 2, g / 2, b / 2);
    box(430, 500, 100);
    translate(55, -250);
  }


  void start_calibration() {
    calibrating = true;
    cal_start_time = millis();
    f1.set_value_flat(4096);
    f1.set_value_folded(0);

    f2.set_value_flat(4096);
    f2.set_value_folded(0);

    f3.set_value_flat(4096);
    f3.set_value_folded(0);

    f4.set_value_flat(4096);
    f4.set_value_folded(0);

    f5.set_value_flat(4096);
    f5.set_value_folded(0);
  }

  void draw_calibrate() {
    background(200);

    camera();  // Camera par defaut

    fill(0);  // Texte noir
    textSize(50);
    text("Calibration en cours...", width/2, height/2);


    if (tab[0] > f1.get_value_folded())
      f1.set_value_folded(tab[0]);
    else if (tab[0] < f1.get_value_flat())
      f1.set_value_flat(tab[0]);

    if (tab[1] > f2.get_value_folded())
      f2.set_value_folded(tab[1]);
    else if (tab[1] < f2.get_value_flat())
      f2.set_value_flat(tab[1]);

    if (tab[2] > f3.get_value_folded())
      f3.set_value_folded(tab[2]);
    else if (tab[2] < f3.get_value_flat())
      f3.set_value_flat(tab[2]);

    if (tab[3] > f4.get_value_folded())
      f4.set_value_folded(tab[3]);
    else if (tab[3] < f4.get_value_flat())
      f4.set_value_flat(tab[3]);

    if (tab[4] > f5.get_value_folded())
      f5.set_value_folded(tab[4]);
    else if (tab[4] < f5.get_value_flat())
      f5.set_value_flat(tab[4]);

    // Verfier que le temps de calibration n'est pas fini
    if (millis() - cal_start_time > CAL_DURATION) {
      calibrating = false;
    }
  }
}

class Finger {
  int m_pos_x, m_pos_y;
  int m_value_flat = 1900;  // Valeur par defaut, remplacée via la fonction calibrate
  int m_value_folded = 4000;  // Valeur par defaut, remplacée via la fonction calibrate
  float m_Hfactor = 1;  // Height factor
  boolean m_is_thumb;  // Si le doigt correspond

  Finger(int x, int y, boolean thumb) {
    m_pos_x = x;
    m_pos_y = y;
    m_is_thumb = thumb;
  }
  
  int get_value_flat() { return m_value_flat; }
  void set_value_flat(int val) { m_value_flat = val; }
  
  int get_value_folded() { return m_value_folded; }
  void set_value_folded(int val) { m_value_folded = val; }

  int get_height() {
    if (m_is_thumb)
      return THUMB_H;
    else
      return FINGER_H;
  }

  float get_Hfactor() {
    return m_Hfactor;
  }
  void set_Hfactor(float new_h_factor) {
    m_Hfactor = new_h_factor;
  }
  
  void set_height(float value) {
    m_Hfactor = (value - get_value_flat()) / (float)(get_value_folded() - get_value_flat());
  }  
  
  void rotationX (boolean set_rotation, int segment) {
    if (set_rotation) {
      if (segment == 1) {
        rotateX((PI/3)*m_Hfactor);
      }
      if (segment == 2) {
        rotateX((PI/2)*m_Hfactor);
      }
      if (segment == 3) {
        rotateX(PI / 2*m_Hfactor);
      }
    }
    else {
      if (segment == 1) {
        rotateX((-PI/3)*m_Hfactor);
      }
      if (segment == 2) {
        rotateX((-PI/2)*m_Hfactor);
      }
      if (segment == 3) {
        rotateX(-PI / 2*m_Hfactor);
      }
    }
  }

  void translateSegment() {

      translate(m_pos_x, m_pos_y);
      rotationX(false, 1);
      translate(0, -get_height()/6);
      
      box(FINGER_W, get_height()/3, FINGER_D);
      
      translate(0, -get_height()/6);
      rotationX(false, 2);
      translate(0, -get_height()/6);
      
      box(FINGER_W, get_height()/3, FINGER_D);
      
      if (!m_is_thumb) {
        translate(0, -get_height()/6);
        rotationX(false,3);
        translate(0, -get_height()/6);
        
        box(FINGER_W, get_height()/3, FINGER_D);
        
        translate(0, get_height()/6);
        rotationX(true, 3);
        translate(0, get_height()/6);
      }
      translate(0, get_height()/6);
      rotationX(true, 2);
      translate(0, get_height()/6);
      
      translate(0, get_height()/6);
      rotationX(true, 1);
      translate(-m_pos_x, -m_pos_y);    
  }
}

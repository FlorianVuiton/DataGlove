#include "BluetoothSerial.h"
BluetoothSerial SerialBT;
int pin36 = 36; // A4
int pin37 = 37; // A5
int pin38 = 38; // A6
int pin39 = 39; // A7
int pin32 = 32; // A0

int quantite_moy = 100;  // Plus c'est proche de 0, plus c'est rapide

void setup() {
 Serial.begin(9600);
 SerialBT.begin("ESP32");
}
void loop() {
  delay(200);
  int somme36 = 0;
  int somme37 = 0;
  int somme38 = 0;
  int somme39 = 0;
  int somme32 = 0;
  
  for (int i = 0; i < quantite_moy; i++) {
    int tension36 = analogRead(pin36);
    int tension37 = analogRead(pin37);
    int tension38 = analogRead(pin38);
    int tension39 = analogRead(pin39);
    int tension32 = analogRead(pin32);
    somme36 += tension36;
    somme37 += tension37;
    somme38 += tension38;
    somme39 += tension39;
    somme32 += tension32;
  }
  
 SerialBT.print(somme36 / quantite_moy);
 SerialBT.print(' ');
 SerialBT.print(somme37 / quantite_moy);
 SerialBT.print(' ');
 SerialBT.print(somme38 / quantite_moy);
 SerialBT.print(' ');
 SerialBT.print(somme39 / quantite_moy);
 SerialBT.print(' ');
 SerialBT.print(somme32 / quantite_moy);
 SerialBT.print('\n');
}

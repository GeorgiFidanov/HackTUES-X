#include <WiFiManager.h>

const int soundLevelPin = 32;
const int photoResistorPin = 4; //Tolerance +-0.1%
const int salinityLevelPin = 13;

void  setup() {
  Serial.begin(9600);

  //Wi-Fi connection
  /*WiFiManager wm;
  bool res = wm.autoConnect("AutoConnectAP", "password");
  if (!res) {
    Serial.println("Failed to connect");
  } else {
    Serial.println("connected...yeey :)");
  }*/
}

void loop() {
  int photoResistorValue = analogRead(photoResistorPin);
  int soundLevelValue = analogRead(soundLevelPin);
  int salinityLevelValue = analogRead(salinityLevelPin);

  Serial.print("Light level: ");
  Serial.println(photoResistorValue);
  Serial.print("Sound level: ");
  Serial.println(soundLevelValue); 
  Serial.print("Salinity level: ");
  Serial.println(salinityLevelValue);

  delay(500);
}
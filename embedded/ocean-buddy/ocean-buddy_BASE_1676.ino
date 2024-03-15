#include <WiFiManager.h>
#include "DHT.h"


const int soundLevelPin = 32;
const int photoResistorPin = 4; // Tolerance +-0.1%
const int salinityLevelPin = 13;
const int temperaturePin = 19; // +-0.5C

DHT dht(temperaturePin, DHT22);

void setup() {
  Serial.begin(9600);
  dht.begin();
  // Wi-Fi connection
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
  float temperatureValue = dht.readTemperature(false);

  Serial.print("Light level: ");
  Serial.println(photoResistorValue);
  Serial.print("Sound level: ");
  Serial.println(soundLevelValue);
  Serial.print("Salinity level: ");
  Serial.println(salinityLevelValue);
  Serial.print("Temperature: ");
  Serial.println(temperatureValue);
  //check

  delay(10000);
}

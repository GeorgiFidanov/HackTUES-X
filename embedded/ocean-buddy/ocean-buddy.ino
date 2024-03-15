#include <WiFiManager.h>
#include "DHT.h"

#define V_REF 3.3

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

  float voltageLight = (photoResistorValue / 4095.0) * V_REF;
  float voltageSalt = (salinityLevelValue / 4095.0) * V_REF;
  float voltageSound = (soundLevelValue / 4095.0) * V_REF;

  Serial.print("Light level: ");
  Serial.println(photoResistorValue);
  Serial.print("Light voltage: ");
  Serial.println(voltageLight);
  Serial.print("Sound level: ");
  Serial.println(soundLevelValue);
  Serial.print("Sound voltage: ");
  Serial.println(voltageSound);
  Serial.print("Salinity level: ");
  Serial.println(salinityLevelValue);
  Serial.print("Salinity voltage: ");
  Serial.println(voltageSalt);
  Serial.print("Temperature: ");
  Serial.println(temperatureValue);

  delay(10000);
}

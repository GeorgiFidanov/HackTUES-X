#include <WiFiManager.h>
#include <HTTPClient.h>
#include <stdio.h>
#include "DHT.h"
#define V_REF 3.3
#define ID 1
#include <string>


const int soundLevelPin = 32;
const int photoResistorPin = 4; // Tolerance +-0.1%
const int salinityLevelPin = 13;
const int temperaturePin = 19; // +-0.5C
const char* serverName = "http://192.168.166.172:8000/api/data";

DHT dht(temperaturePin, DHT22);

void setup() {
  Serial.begin(9600);
  dht.begin();
  WiFiManager wm;
  bool res = wm.autoConnect("AutoConnectAP", "password");
  if (!res) {
    Serial.println("Failed to connect");
  } else {
    Serial.println("connected...yeey :)");
  }
}

void loop() {
  int photoResistorValue = analogRead(photoResistorPin);
  int soundLevelValue = analogRead(soundLevelPin);
  int salinityLevelValue = analogRead(salinityLevelPin);
  float temperatureValue = dht.readTemperature(false);
  float voltagePhoto = (photoResistorValue / 4095.0) * V_REF;
  float voltageSound = (soundLevelValue / 4095.0) * V_REF;
  float voltageSalt = (salinityLevelValue / 4095.0) * V_REF;
  HTTPClient http;
  http.begin(serverName);
  http.addHeader("Content-Type", "application/json");
  std::string httpRequestData = "[{\"device_id\":"+ std::to_string(ID) +",\"temperature\":27,\"noise\":"+ std::to_string(voltageSound) +",\"salinity\":"+ std::to_string(voltageSalt) +",\"murkiness\":"+ std::to_string(voltagePhoto) +"}]";
  int httpResponseCode = http.POST(httpRequestData.c_str());
  Serial.print("HTTP Response code: ");
  Serial.println(httpResponseCode);
  http.end();


  Serial.println(httpRequestData.c_str());
  Serial.print("Light level - ");
  Serial.println(photoResistorValue);
  Serial.print("Light level volts - ");
  Serial.println(voltagePhoto);
  Serial.print("Sound level - ");
  Serial.println(soundLevelValue);
  Serial.print("Sound level volts - ");
  Serial.println(voltageSound);

  Serial.print("Salinity level - ");
  Serial.println(salinityLevelValue);
  Serial.print("Salinity level volts - ");

  Serial.println(voltageSalt);
  Serial.print("Temperature: ");
  Serial.println(temperatureValue);

  delay(10000);
  Serial.println();
  Serial.println();
  Serial.println();
  Serial.println();
  Serial.println();
  Serial.println();
}
#include <WiFiManager.h>
#include <HTTPClient.h>
#include <Ticker.h>
#include <stdio.h>
#include "DHT.h"
#define V_REF 3.3
#define ID 1
#include <string>

const int soundLevelPin = 32;
const int photoResistorPin = 33; // Tolerance +-0.1%
const int salinityLevelPin = 35;
const int temperaturePin = 19; // +-0.5C
const char* serverName = "http://192.168.166.172:8000/api/data";

DHT dht(temperaturePin, DHT22);

void sendData() {
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
  std::string httpRequestData = "[{\"device_id\":"+ std::to_string(ID) +",\"temperature\":"+ std::to_string(temperatureValue) +",\"noise\":"+ std::to_string(voltageSound) +",\"salinity\":"+ std::to_string(voltageSalt) +",\"murkiness\":"+ std::to_string(voltagePhoto) +"}]";
  int httpResponseCode = http.POST(httpRequestData.c_str());
  Serial.print("HTTP Response code: ");
  Serial.println(httpResponseCode);
  http.end();
}

Ticker timer;

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

  timer.attach(600.0, sendData);
}
void loop() {

}


//Include the used libraries
#include <WiFiManager.h>
#include <HTTPClient.h>
#include <Ticker.h>
#include <stdio.h>
#include "DHT.h"
#include <string>

//Define constants
#define V_REF 3.3
#define ID 1

//Define pins used by sensors
const int soundLevelPin = 32;
const int photoResistorPin = 33; // Tolerance +-0.1%
const int salinityLevelPin = 35;
const int temperaturePin = 19; // +-0.5C

//Set the address on which the data is sent to the backend
const char* serverName = "http://192.168.166.172:8000/api/data";

DHT dht(temperaturePin, DHT22);

//Define the callback function to be executed every 10 minutes
void sendData() {
  
  //Read data from the sensors
  int photoResistorValue = analogRead(photoResistorPin);//Murkiness
  int soundLevelValue = analogRead(soundLevelPin);//Noise
  int salinityLevelValue = analogRead(salinityLevelPin);//Salinity
  float temperatureValue = dht.readTemperature(false);//Temperature
  float voltagePhoto = (photoResistorValue / 4095.0) * V_REF;
  float voltageSound = (soundLevelValue / 4095.0) * V_REF;
  float voltageSalt = (salinityLevelValue / 4095.0) * V_REF;

  //Create HTTP POST request
  HTTPClient http;
  http.begin(serverName);
  
  //Fill the request with the mesured data
  http.addHeader("Content-Type", "application/json");
  std::string httpRequestData = "[{\"device_id\":"+ std::to_string(ID) +",\"temperature\":"+ std::to_string(temperatureValue) +",\"noise\":"+ std::to_string(voltageSound) +",\"salinity\":"+ std::to_string(voltageSalt) +",\"murkiness\":"+ std::to_string(voltagePhoto) +"}]";

  //Send the request and display the response
  int httpResponseCode = http.POST(httpRequestData.c_str());
  Serial.print("HTTP Response code: ");
  Serial.println(httpResponseCode);
  
  //Handle the end of the connection with the backend
  http.end();
}
//Define timer
Ticker timer;

void setup() {
  Serial.begin(9600);
  dht.begin();
  
  //Setup WiFi connection at the beginning of the execution and display result in the console
  WiFiManager wm;
  bool res = wm.autoConnect("AutoConnectAP", "password");
  if (!res) {
    Serial.println("Failed to connect");
  } else {
    Serial.println("connected...yeey :)");
  }
  
  //Setup the timer to call sendData() every 10 minutes
  timer.attach(600.0, sendData);
}

void loop() {

}


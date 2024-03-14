const int soundPin = 32;
const int photoResistorPin = 4; //Tolerance +-0.1%

void  setup() {
  Serial.begin(9600);
}

void loop() {
  int photoResistorValue = analogRead(photoResistorPin);
  int soundValue = analogRead(soundPin); // Read the analog value from the sound sensor
  Serial.print("Light level:");
  Serial.println(photoResistorValue);
  Serial.print("Sound level:");
  Serial.println(soundValue); // Print the value to the serial monitor

  delay(500);
}
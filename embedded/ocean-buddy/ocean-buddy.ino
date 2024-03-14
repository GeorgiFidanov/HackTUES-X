const int soundPin = 32;

void  setup() {
  Serial.begin(9600);
}

void loop() {
  int soundValue = analogRead(soundPin); // Read the analog value from the sound sensor
  Serial.println(soundValue); // Print the value to the serial monitor
  delay(1000); // Delay for a second before reading again
}
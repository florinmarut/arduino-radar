#include <Servo.h>

const int trigPin = 13;
const int echoPin = 12;

long duration;
int distance;

Servo myServo;

int pos = 0;

void setup() {
  myServo.attach(8);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);
}

void loop() {
    for(pos = 0; pos <= 180; pos += 1){
    distance = calculateDistance();
    myServo.write(pos);
    Serial.print(pos);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
    delay(15);
  }

  for(pos = 180; pos >= 0; pos -= 1){
    distance = calculateDistance();
    myServo.write(pos);
    Serial.print("(");
    Serial.print(pos);
    Serial.print(", ");
    Serial.print(distance);
    Serial.print(")");
    delay(15);
  }
}

int calculateDistance(){
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  duration = pulseIn(echoPin, HIGH);
  distance = duration*0.034/2;
  return distance;
}

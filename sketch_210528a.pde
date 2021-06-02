import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
Serial myPort; 

String angle="";
String distance="";
String data="";
String objectRange;
float distanceInPixels;
int angleValue, distanceValue;
int dot=0;

void setup() {
 size (1920, 1080); // setting up the canvas which should fit an 1920x1080 screen
 smooth();
 myPort = new Serial(this,"COM3", 9600);
 myPort.bufferUntil('.');
}
void draw() {
  fill(98,245,31);
  // this simulates the motion blur and slow fade of the moving line
  noStroke();
  fill(0,4); 
  rect(0, 0, width, 1010); 
  
  fill(98,245,31); // this is the green color that the line will use to be drawn
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}
void serialEvent (Serial myPort) { 
  // the app receives the angle and the distance through the serial port as a touple (separated by "," and ending with ".")
  
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  dot = data.indexOf(",");
  angle = data.substring(0, dot);
  distance= data.substring(dot+1, data.length());
  
  // convert the angle and distance from string to integer
  angleValue = int(angle);
  distanceValue = int(distance);
}
void drawRadar() {
  pushMatrix();
  translate(1100,1000);
  noFill();
  stroke(98,245,31);
  // draws the arc lines
  arc(0,0,1600,1600,PI,TWO_PI);
  arc(0,0,1280,1280,PI,TWO_PI);
  arc(0,0,960,960,PI,TWO_PI);
  arc(0,0,640,640,PI,TWO_PI);
  arc(0,0,320,320,PI,TWO_PI);
  popMatrix();
}
void drawObject() {
  pushMatrix();
  translate(1100,1000);
  strokeWeight(5);
  stroke(255,10,10);
  distanceInPixels = distanceValue*8;
  if(distanceValue<100){ // it will draw the red line only if the object is in a range of 1 meter
    line(distanceInPixels*cos(radians(angleValue)),-distanceInPixels*sin(radians(angleValue)),800*cos(radians(angleValue)),-800*sin(radians(angleValue)));
  }
  popMatrix();
}
void drawLine() {
  pushMatrix();
  strokeWeight(5);
  stroke(30,250,60);
  translate(1100,1000);
  line(0,0,800*cos(radians(angleValue)),-800*sin(radians(angleValue)));
  popMatrix();
}
void drawText() {
  pushMatrix();
  if(distanceValue>100) {
  objectRange = "Out of range";
  }
  else {
  objectRange = "In range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, 0, 360, 325);
  fill(98,245,31);
  textSize(25);
  text("20cm",1070,825);
  text("40cm",1070,670);
  text("60cm",1070,500);
  text("80cm",1070,350);
  text("100cm",1070,190);
  textSize(35);
  text("Object: " + objectRange, 0, 100);
  text("Angle: " + angleValue +" °", 0, 200);
  if(distanceValue<100) {
     text("Distance: " + distanceValue + " cm", 0, 300);
  }
  popMatrix(); 
}

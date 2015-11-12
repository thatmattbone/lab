/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */
 
// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int red = 12;
int yellow = 11;
int green = 10;
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by

int val = -1;
int prev = -1;

void red_solid() {
  digitalWrite(red, HIGH);
  digitalWrite(yellow, LOW);
  digitalWrite(green, LOW);
 
}

void yellow_fading() {
  digitalWrite(red, LOW);
  digitalWrite(green, LOW);
  
  // set the brightness of pin 9:
  analogWrite(yellow, brightness);    

  // change the brightness for next time through the loop:
  brightness = brightness + fadeAmount;

  // reverse the direction of the fading at the ends of the fade:
  if (brightness == 0 || brightness == 255) {
    fadeAmount = -fadeAmount ;
  }    
  // wait for 30 milliseconds to see the dimming effect    
  delay(30);  
}

void green_solid() {
  digitalWrite(red, LOW);
  digitalWrite(yellow, LOW);
  digitalWrite(green, HIGH);
}

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  pinMode(red, OUTPUT);
  pinMode(yellow, OUTPUT);
  pinMode(green, OUTPUT);
  
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  
  val = Serial.read();
  if (val == -1) {
    val = prev;
  }
  
  if (val != -1) {
    if(val != prev) {
      Serial.println(val);
    }

    //109 = "m" in dec from ascii
    if (val == 110) { 
      if (val != prev) {
        Serial.println("red solid");
      }
      red_solid();
    } else if (val == 109) { 
      if (val != prev) {
        Serial.println("yellow fading");
      }
      yellow_fading();
    } else if (val == 108) {
      if (val != prev) {
        Serial.println("green solid");
      }
      green_solid();
    }
    
    prev = val;
  }
}

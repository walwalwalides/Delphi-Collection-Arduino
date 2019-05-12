//{ ============================================
//  Software Name : 	RGB_LED
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }

#include <SoftwareSerial.h>

SoftwareSerial BLU(0,1);

#define redPin 3
#define greenPin 5 
#define bluePin 6

void setup()
{
  //Serial setup
  Serial.begin(9600);
  Serial.println("-= LED MIXER (SER) =-");


  BLU.begin(9600);
  BLU.println("-= LED MIXER (BLU) =-");
  
 
  pinMode(4, OUTPUT);
 
  digitalWrite(4,HIGH);


  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);


// setColor(255, 0, 0);
//  delay(500);
 // setColor(0, 255, 0);
 // delay(500);
  //setColor(0, 0, 255);
  //delay(500);
  //setColor(255, 255, 255);
}

void loop()
{
  while (BLU.available() > 0)
  {
    int redInt = BLU.parseInt();
    int greenInt = BLU.parseInt();
    int blueInt = BLU.parseInt();

    redInt = constrain(redInt, 0, 255);
    greenInt = constrain(greenInt, 0, 255);
    blueInt = constrain(blueInt, 0, 255);

    if (BLU.available() > 0)
    {
      setColor(redInt, greenInt, blueInt);

      Serial.print("Red: ");
      Serial.print(redInt);
      Serial.print(" Green: ");
      Serial.print(greenInt);
      Serial.print(" Blue: ");
      Serial.print(blueInt);
      Serial.println();

      BLU.flush();
    }
  }
}

void setColor(int red, int green, int blue)
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);
}

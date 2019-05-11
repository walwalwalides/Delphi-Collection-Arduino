//{ ============================================
//  Software Name : 	OLEDDisplay
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }
 

// Include Wire Library for I2C
#include <Wire.h>
 
// Include Adafruit Graphics & OLED libraries
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
 
// Include Adafruit AM2320 Temp Humid Library

 
// Reset pin not used but needed for library
#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);
 



String inputString = "";    
boolean stringComplete = false; 


void setup() {
  // put your setup code here, to run once:
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  Serial.begin(9600);
  // reserve 200 bytes for the inputString:
  inputString.reserve(200);

}


void DisplayValue1(int AValue)
{
  display.setCursor(0,10); 
  display.print("Value1:    "); 
  display.print(AValue);
  

}

void DisplayValue2 (int AValue){

  display.setCursor(0,20);
  display.print("Value2: "); 
  display.print(AValue);

}



void loop() {
    // Delay to allow sensor to stabalize
  // Clear the display
  display.clearDisplay();
  //Set the color - always use white despite actual display color
  display.setTextColor(WHITE);
  //Set the font size
  display.setTextSize(1);
  //Set the cursor coordinates
  display.setCursor(30,0);
  display.print("OLEDDispaly");
 
  
  if (stringComplete) {
       
    int lastValue1 = inputString.lastIndexOf('#');
    int lastValue2 = inputString.lastIndexOf('&');
    if (lastValue1 > 0) 
    {
    inputString.remove(inputString.length() - 1,1);     
     DisplayValue1(inputString.toInt());
     Serial.println("Value 1 : "+inputString); 
     }   

    
    if (lastValue2 > 0) 
    {
     inputString.remove(inputString.length() - 1,1);     
     DisplayValue2(inputString.toInt());
     Serial.println("Value 2 : "+inputString); 
     } 
    display.display();
    inputString = "";
    stringComplete = false;
  } 
}

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '#') {
      stringComplete = true;
      
    }
  }
}

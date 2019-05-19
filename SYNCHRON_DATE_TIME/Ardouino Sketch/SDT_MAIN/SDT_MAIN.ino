//{ ============================================
//  Software Name :   SDT
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }

#include <TimeLib.h>
#define TIME_HEADER  "T"   // Header tag for serial time sync message
#define TIME_REQUEST  7    // ASCII bell character requests a time sync message 
#define TIME_MSG_LEN  11   // time sync to PC is HEADER and unix time_t as ten ascii digits


#include <SD.h> //Load SD library

int chipSelect = 4; //chip select pin for the MicroSD Card Adapter
File file; // file object that is used to read and write data
//Constants
const int buttonPin = 7;
const int button2Pin = 9;
const int ledPin =  3;
int buttonState = 0;
int button2State = 0;
int flag = 0;
String SynchroDT;


void setup() {
  Serial.begin(9600); // start serial connection to print out debug messages and data
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(8, OUTPUT);




  pinMode(chipSelect, OUTPUT); // chip select pin must be set to OUTPUT mode

  if (!SD.begin(chipSelect)) { // Initialize SD card
    Serial.println("Could not initialize SD card."); // if return value is false, something went wrong.
  }

  if (SD.exists("file.txt")) { // if "file.txt" exists, fill will be deleted
    Serial.println("File exists.");
    if (SD.remove("file.txt") == true) {
      Serial.println("Successfully removed file.");
    } else {
      Serial.println("Could not removed file.");
    }
  }
  setSyncProvider( requestSync);  //set function to call when sync required
  Serial.println("Waiting for sync message");
}


void loop() {

  if (Serial.available()) {
    processSyncMessage();
  }
  if (timeStatus() != timeNotSet && SynchroDT == "") {
    digitalClockDisplay();
  }
  if (timeStatus() == timeSet && SynchroDT != "") {
    digitalWrite(8, HIGH); // LED on if synced
  } else {
    digitalWrite(8, LOW);  // LED off if needs refresh
  }
  delay(500);

  buttonState = digitalRead(buttonPin);
  if (buttonState == HIGH) {            //check if the pushbutton is pressed
    //if it is, the buttonState is HIGH
    digitalWrite(ledPin, HIGH);         //turn LED on
    WriteSDCard();
  }
  
  else {

    digitalWrite(ledPin, LOW);          // turn LED off
  }


  button2State = digitalRead(button2Pin);
  if (button2State == HIGH) 
  { 
    RedSDCard();
  }

}

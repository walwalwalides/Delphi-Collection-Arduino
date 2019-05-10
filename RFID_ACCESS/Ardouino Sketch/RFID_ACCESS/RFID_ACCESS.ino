#include <MFRC522.h>

/*
 * Typical pin layout used:
 * -----------------------------------------------------------------------------------------
 *             MFRC522      Arduino       Arduino   Arduino    Arduino          Arduino
 *             Reader/PCD   Uno/101       Mega      Nano v3    Leonardo/Micro   Pro Micro
 * Signal      Pin          Pin           Pin       Pin        Pin              Pin
 * -----------------------------------------------------------------------------------------
 * RST/Reset   RST          9             5         D9         RESET/ICSP-5     RST
 * SPI SS      SDA(SS)      10            53        D10        10               10
 * SPI MOSI    MOSI         11 / ICSP-4   51        D11        ICSP-4           16
 * SPI MISO    MISO         12 / ICSP-1   50        D12        ICSP-1           14
 * SPI SCK     SCK          13 / ICSP-3   52        D13        ICSP-3           15
 */

#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN   9     // SPI Reset Pin
#define SS_PIN    10    // SPI Slave Select Pin

MFRC522 mfrc522(SS_PIN, RST_PIN);   // Instanz des MFRC522 erzeugen

byte blue_uid[] = {0xD9, 0x98, 0x76, 0x48};
byte red_uid[] = {0x89, 0x7E, 0x3D, 0x56};

int blue_led = 5; // Pin User1 LED
int red_led = 3; // Pin User2 LED

int blue_check = false;
int red_check = false;


void setup() {

  Serial.begin(9600);  // initial serial Communication
  SPI.begin();         // Initial SPI Communication
  mfrc522.PCD_Init();  // Initial MFRC522 Module
  pinMode(blue_led, OUTPUT);
  pinMode(red_led, OUTPUT);
}

void loop() {
  // PICC = proximity integrated circuit card ()
  if (mfrc522.PICC_IsNewCardPresent() && mfrc522.PICC_ReadCardSerial() ) {
    //Serial.print("Gelesene UID:");
    for (byte i = 0; i < mfrc522.uid.size; i++) {
      // Hex separate
      Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : "");
      Serial.print(mfrc522.uid.uidByte[i], HEX);
     if (i < mfrc522.uid.size-1)  
     { Serial.print("-");}
    } 
    Serial.println();
  
    // UID 1 Compair
    blue_check = true;
    for (int j=0; j<4; j++) {
      if (mfrc522.uid.uidByte[j] != blue_uid[j]) {
        blue_check = false;
      }
    }
  
    // UID 2 Compair
    red_check = true;
    for (int j=0; j<4; j++) {
      if (mfrc522.uid.uidByte[j] != red_uid[j]) {
        red_check = false;
      }
    }
  
    if (blue_check) {
      digitalWrite(blue_led, HIGH);
    }
    
    if (red_check) {
      digitalWrite(red_led, HIGH);
    }

    mfrc522.PICC_HaltA();
    delay(1000);
    digitalWrite(blue_led, LOW);
    digitalWrite(red_led, LOW);
  }

}

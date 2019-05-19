//{ ============================================
//  Software Name :   SDT
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }
void RedSDCard()
{
 file = SD.open("file.txt", FILE_READ); // open "file.txt" to read data
    if (file) {
      Serial.println("--- Reading Logging ---");
      char character;
      while ((character = file.read()) != -1) { // this while loop reads data stored in "file.txt" and prints it to serial monitor
        Serial.print(character);
      }
      file.close();
      Serial.println("-------------------");
    } 
    else {
      Serial.println("Could not open file (reading).");
    }
}

void WriteSDCard()
{


    file = SD.open("file.txt", FILE_WRITE); // open "file.txt" to write data
    if (file)
    {
      if (SynchroDT != "")
      {
        digitalWrite(8, LOW);  // LED off if needs refresh
        file.println(SynchroDT); // write number to file
        file.close(); // close file
        Serial.print("DATETIME SYNCHRON TO : "); // debug output: show written number in serial monitor
        Serial.println(SynchroDT);
        SynchroDT = "";
      }
    }
    else
    {
      Serial.println("Could not open file (writing).");
    }
  
}

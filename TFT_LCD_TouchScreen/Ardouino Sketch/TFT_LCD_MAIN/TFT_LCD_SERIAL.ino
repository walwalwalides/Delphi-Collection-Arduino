//{ ============================================
//  Software Name :   TFT_LCD_TOUCHSCREEN
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }
//
void serialEvent() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag so the main loop can
    // do something about it:
    if (inChar == '\n') {
      stringComplete = true;

    }

  }
}

//
//    if (BoolTime=false)
//    {
//     processSyncMessage();
//   if (timeStatus() != timeNotSet && SynchroDT == "") 
//  {    
//    digitalClockDisplay();
//    BoolTime =true;
//  } 
//    } 

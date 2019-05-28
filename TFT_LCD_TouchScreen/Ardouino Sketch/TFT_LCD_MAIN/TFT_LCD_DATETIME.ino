//{ ============================================
//  Software Name :   TFT_LCD_TOUCHSCREEN
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }

void digitalClockDisplay(){
  // digital clock display of the time
  
  Serial.print(hour());
  SynchroDT=SynchroDT+hour();
  printDigits(minute());
  SynchroDT=SynchroDT+minute();
  printDigits(second());
  SynchroDT=SynchroDT+second();
  Serial.print(" ");
  SynchroDT=SynchroDT+" ";
  Serial.print(day());
  SynchroDT=SynchroDT+day();
  Serial.print(" ");
  SynchroDT=SynchroDT+" ";
  Serial.print(month());
  SynchroDT=SynchroDT+month();
  Serial.print(" ");
  SynchroDT=SynchroDT+" ";
  Serial.print(year()); 
  SynchroDT=SynchroDT+year();
  Serial.println(); 
}

void printDigits(int digits){
  // utility function for digital clock display: prints preceding colon and leading 0
  Serial.print(":");
  SynchroDT=SynchroDT+":";
  if(digits < 10)  
{ 
    Serial.print('0');   
    SynchroDT=SynchroDT+'0';
}
  Serial.print(digits);
  
}


void processSyncMessage() {
  unsigned long pctime;
  const unsigned long DEFAULT_TIME = 1357041600; // Jan 1 2013

  if(Serial.find(TIME_HEADER)) {
     pctime = Serial.parseInt();
     if( pctime >= DEFAULT_TIME) { // check the integer is a valid time (greater than Jan 1 2013)
       setTime(pctime); // Sync Arduino clock to the time received on the serial port
     }
  }
}

time_t requestSync()
{
  Serial.write(TIME_REQUEST);  
  return 0; // the time will be sent later in response to serial mesg
}

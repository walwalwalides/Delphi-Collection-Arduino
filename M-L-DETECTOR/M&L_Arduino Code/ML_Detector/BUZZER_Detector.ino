//{ ============================================
//  Software Name :   ML_DETECTOR
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }

const int c = 261;
const int d = 294;
const int e = 329;
const int f = 349;
const int g = 391;
const int gS = 415;
const int a = 440;
const int aS = 455;
const int b = 466;
const int cH = 523;
const int cSH = 554;
const int dH = 587;
const int dSH = 622;
const int eH = 659;
const int fH = 698;
const int fSH = 740;
const int gH = 784;
const int gSH = 830;
const int aH = 880;
 

const int ledPin1 = 12;
const int ledPin2 = 13;
const int buzzerPin = 10; 
int counter = 0;
 


 
void beep(int note, int duration)
{
 //Play tone on buzzerPin
 
// tone(buzzerPin, note, duration);
//  noTone(buzzerPin);
 //Play different LED depending on value of 'counter'
 if(counter % 2 == 0)
 {
 digitalWrite(ledPin1, HIGH);
 delay(duration);
 digitalWrite(ledPin1, LOW);
 }else
 {
 digitalWrite(ledPin2, HIGH);
 delay(duration);
 digitalWrite(ledPin2, LOW);
 }
 

 //Stop tone on buzzerPin

 
 delay(50);
 
 //Increment counter
 counter++;
}

void ON_Func1()
{

tone(buzzerPin, c, 50);
delay(100);
}

void ON_Func2()
{

tone(buzzerPin,d, 50);
delay(100);

}
 
void firstSection()
{

//  pinMode(buzzerPin, OUTPUT); 
 beep(a, 500);
 beep(a, 500); 
 beep(cH, 150); 
 beep(a, 500);
  

}
 

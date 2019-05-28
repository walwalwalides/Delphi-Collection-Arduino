//{ ============================================
//  Software Name :   TFT_LCD_TOUCHSCREEN
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }
#include <Adafruit_TFTLCD.h> 
#include <Adafruit_GFX.h>    
#include <TouchScreen.h>

#define LCD_CS A3 
#define LCD_CD A2 
#define LCD_WR A1 
#define LCD_RD A0 
#define LCD_RESET A4 

#define TS_MINX 122
#define TS_MINY 111
#define TS_MAXX 942
#define TS_MAXY 890

#define YP A3
#define XM A2
#define YM 9
#define XP 8

#define BLACK   0x0000
#define BLUE    0x001F
#define RED     0xF800
#define GREEN   0x07E0
#define CYAN    0x07FF
#define MAGENTA 0xF81F
#define YELLOW  0xFFE0
#define WHITE   0xFFFF
String myArtical = "";
String myPrice = "";
String myString = "";
String inputString = "";
int p;
char charBuf[50];
String outputString = ""; // a String to hold incoming data
bool stringComplete = false;  // whether the string is complete

Adafruit_TFTLCD tft(LCD_CS, LCD_CD, LCD_WR, LCD_RD, LCD_RESET);

TouchScreen ts = TouchScreen(XP, YP, XM, YM, 364);

boolean buttonEnabled = true;

void setup() {
  Serial.begin(9600);
  tft.reset();
  
  uint16_t identifier = tft.readID();
  tft.begin(identifier);
  tft.setRotation(1);
  tft.fillScreen(WHITE);
  tft.drawRect(0,0,319,240,YELLOW);
  
  tft.setCursor(30,40);
  tft.setTextColor(CYAN);
  tft.setTextSize(2);
  tft.print("TFT LCD Touch Screen");
  
  tft.setCursor(115,80);
  tft.setTextColor(BLACK);
  tft.setTextSize(2);
  tft.print("Tutorial\n\n            by");
  
  tft.setCursor(90,150);
  tft.setTextColor(RED);
  tft.setTextSize(2);
  tft.print("WalWalWalides");
  
  tft.fillRect(0,180, 400, 40, RED);
  tft.drawRect(0,180,400,40,BLACK);
  tft.setCursor(60,190);
  tft.setTextColor(GREEN);
  tft.setTextSize(1);
  tft.print("Please Send Text Trought Serial Port");

}


char StrContains(char *str, char *sfind)
{
    char found = 0;
    char index = 0;
    char len;

    len = strlen(str);
    
    if (strlen(sfind) > len) {
        return 0;
    }
    while (index < len) {
        if (str[index] == sfind[found]) {
            found++;
            if (strlen(sfind) == found) {
                return index;
            }
        }
        else {
            found = 0;
        }
        index++;
    }

    return 0;
}


void loop() {

 if (stringComplete)
  {
    int stringName = inputString.lastIndexOf('+');
    if (stringName > 0)
    {
      inputString.remove(inputString.length() - 2, 1);  

    Serial.println("Set Name to : " + inputString);
    pinMode(XM, OUTPUT);
    pinMode(YP, OUTPUT);
    tft.fillScreen(WHITE);
    tft.drawRect(0,0,319,240,YELLOW);
    tft.setCursor(50,70);
    tft.setTextColor(BLACK);
    tft.setTextSize(3);
    tft.print(" Hallo ");  
    tft.setTextColor(RED);
    tft.setTextSize(3);
    tft.print(inputString);        
        inputString = "";
        stringComplete = false;  
      
    }

  //------------------------------$ Dollar-----------------------------    
    int stringPriceD = inputString.lastIndexOf('$');
    if (stringPriceD > 0)
    {
     p = 0;  
    //  inputString.remove(inputString.length() - 2, 1);  
    myString = "";
    myArtical  = "";
    myPrice  = "";
   myString = inputString;
  int str_len = inputString.length() + 1; 
  char char_array[str_len];
  myString.toCharArray(char_array, str_len);
  Serial.println();
    
    Serial.println("Set Price to : " + inputString);
    pinMode(XM, OUTPUT);
    pinMode(YP, OUTPUT);
    tft.fillScreen(WHITE);



  for (int i = 0; i < str_len; i++) 
  {
  if (char_array[i] == '-')
  {
   p = i;  
 }   
  }      
    
   myArtical = inputString.substring(0,p);
   myPrice= inputString.substring(p+1,str_len);  
   
    tft.drawRect(0,50,319,240,BLUE);
    tft.setCursor(45,15);
    tft.setTextColor(BLUE);
    tft.setTextSize(3);    
    tft.print(myArtical); 
    tft.setCursor(45,120); 
    tft.setTextColor(RED);
    tft.setTextSize(8);
    
    tft.print(myPrice);        
   
   inputString = "";
   stringComplete = false;  
      
    } 
    
  

 //------------------------------€ Euro----------------------------- 
    int stringPriceE = inputString.lastIndexOf('€');
    if (stringPriceE > 0)
    {
     p = 0;  
    //  inputString.remove(inputString.length() - 2, 1);  
    myString = "";
    myArtical  = "";
    myPrice  = "";
   myString = inputString;
  int str_len = inputString.length() + 1; 
  char char_array[str_len];
  myString.toCharArray(char_array, str_len);
  Serial.println();
    
    Serial.println("Set Price to : " + inputString);
    pinMode(XM, OUTPUT);
    pinMode(YP, OUTPUT);
    tft.fillScreen(WHITE);



  for (int i = 0; i < str_len; i++) 
  {
  if (char_array[i] == '-')
  {
   p = i;  
 }   
  }      
    
   myArtical = inputString.substring(0,p);
   myPrice= inputString.substring(p+1,str_len);  
   
    tft.drawRect(0,50,319,240,BLUE);
    tft.setCursor(45,15);
    tft.setTextColor(BLUE);
    tft.setTextSize(3);    
    tft.print(myArtical); 
    tft.setCursor(45,120); 
    tft.setTextColor(RED);
    tft.setTextSize(8);
    
    tft.print(myPrice);        
   
   inputString = "";
   stringComplete = false;  
      
    }
  } 
    
    
 //------------------------------TouchScreen----------------------------- 
  
  TSPoint p = ts.getPoint();
  
  if (p.z > ts.pressureThreshhold) {
    
   p.x = map(p.x, TS_MAXX, TS_MINX, 0, 320);
   p.y = map(p.y, TS_MAXY, TS_MINY, 0, 480);
       
   if(p.x>50 && p.x<260 && p.y>200 && p.y<270 && buttonEnabled){
    
    buttonEnabled = false;
    
    pinMode(XM, OUTPUT);
    pinMode(YP, OUTPUT);
    
    tft.fillScreen(WHITE);
    tft.drawRect(0,0,319,240,YELLOW);
    tft.setCursor(10,70);
    tft.setTextColor(RED);
    tft.setTextSize(6);
    tft.print(" Goodbye");
   }  
  }
}

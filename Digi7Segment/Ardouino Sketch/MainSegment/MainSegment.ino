//{ ============================================
//  Software Name : 	Digi7Segment
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }

int E = 13;
int D = 12;
int C = 11;
int DP = 10;
int B = 9;
int A = 8;
int F = 7;
int G = 6;
String inputString = "";    
boolean stringComplete = false; 


void setup() {
  // put your setup code here, to run once:
pinMode(E,OUTPUT);
pinMode(D,OUTPUT);
pinMode(C,OUTPUT);
pinMode(DP,OUTPUT);
pinMode(B,OUTPUT);
pinMode(A,OUTPUT);
pinMode(F,OUTPUT);
pinMode(G,OUTPUT);

  Serial.begin(9600);
  // reserve 200 bytes for the inputString:
  inputString.reserve(200);

}

void loop() {
  // put your main code here, to run repeatedly:
  if (stringComplete) {
    Serial.println(inputString);
    // clear the string:
     if (inputString == "0#") {Zero();}
     if (inputString == "0.#") {ZeroDP();}
     if (inputString == "1#") {One();}
     if (inputString == "1.#") {OneDP();}
     if (inputString == "2#") {Tow();}
     if (inputString == "2.#") {TowDP();}
     if (inputString == "3#") {Three();}
     if (inputString == "3.#") {ThreeDP();}
     if (inputString == "4#") {Four();}
     if (inputString == "4.#") {FourDP();}
     if (inputString == "5#") {Five();}
     if (inputString == "5.#") {FiveDP();}
     if (inputString == "6#") {Six();}
     if (inputString == "6.#") {SixDP();}
     if (inputString == "7#") {Seven();}
     if (inputString == "7.#") {SevenDP();}
     if (inputString == "8#") {Eight();}
     if (inputString == "8.#") {EightDP();}
     if (inputString == "9#") {Nine(); }     
     if (inputString == "9.#") {NineDP(); }
     if (inputString == ".#") {Point();}
    
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


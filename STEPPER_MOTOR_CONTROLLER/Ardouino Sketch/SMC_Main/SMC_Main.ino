//{ ============================================
//  Software Name :   STEP_MOTOR_CONTROLLER
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }
#include <Stepper.h>
#define IN1  8
#define IN2  9
#define IN3  10
#define IN4  11

String inputString = "";
String outputString = ""; // a String to hold incoming data
bool stringComplete = false;  // whether the string is complete
int Steps = 0;
int Direction = 1;
boolean Pause = false;
unsigned long last_time;
unsigned long currentMillis ;
int steps_left = 4095;
long time;
const int button =  4; // direction control button is connected to Arduino pin 4


#define STEPS 20

Stepper stepper(STEPS, 8, 9, 10, 11);


void setup()
{
  Serial.begin(115200);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(button, INPUT_PULLUP);
  //Serial.println("SMC START... ");

}

int direction_ = 1, speed_ = 0;

void loop()
{

  if (stringComplete)
  {
    SetSpeed();
    int DirecPRotation = inputString.lastIndexOf('+');

    if (DirecPRotation > 0)
    {
      inputString.remove(inputString.length() - 2, 2);
      int DirecTPRotation = inputString.lastIndexOf('T');
      if (DirecTPRotation > 0)
      {
        inputString.remove(inputString.length() - 1, 1);
        Serial.println("Turn (+) Continual, Speed : " + inputString);
        Direction =1;//Problem
        speed_ = inputString.toInt();
        inputString = "";

        while (digitalRead(button) == 1)
        {
          stepper.setSpeed(speed_);
          stepper.step(Direction);
        }
        stringComplete = false;
        steps_left = 0;
       Serial.println("Stop");
      }
      else
      {
        steps_left = inputString.toInt();
        inputString = "";


        Serial.println("Step : " + steps_left);
        Direction = 0;
        while (steps_left > 0)
        {
          currentMillis = micros();
          if (currentMillis - last_time >= 1000)
          {
            stepperA(1);

            time = time + micros() - last_time;
            last_time = micros();
            steps_left--;
          }
        }
        stringComplete = false; 
      }
    }

    int DirecNRotation = inputString.lastIndexOf('-');

    if (DirecNRotation > 0)
    {
      inputString.remove(inputString.length() - 2, 2);
      int DirecTNRotation = inputString.lastIndexOf('T');
      if (DirecTNRotation > 0)
      {
        inputString.remove(inputString.length() - 1, 1);
        Serial.println("Turn (-) Continual, Speed : " + inputString);
        Direction = 1;
        speed_ = inputString.toInt();
        inputString = "";
        while (digitalRead(button) == 1)
        {
          stepper.setSpeed(speed_);
          stepper.step(Direction);
        }

        stringComplete = false;
        steps_left = 0;
        Serial.println("Stop");
      }
      else
      {
        steps_left = inputString.toInt();
        inputString = "";

        Serial.println("Step : " + steps_left);
        Direction = 1;
        while (steps_left > 0)
        {
          currentMillis = micros();
          if (currentMillis - last_time >= 1000)
          {
            stepperA(1);

            time = time + micros() - last_time;
            last_time = micros();
            steps_left--;
          }
        }
         stringComplete = false;
      }

    }




  }

}

bool checkPause()
{

  if (stringComplete)
  {

    int PauseRotation = inputString.lastIndexOf('P');
    if (PauseRotation > 0)
    {
      Pause = true;
      Serial.println("Pause");
      inputString = "";
      //  while ( debounce() ) ;
      return 0;
    }
    {
      return 1;
    }

    int StartRotation = inputString.lastIndexOf('R');

    if (StartRotation > 0)
    {
      Serial.println("Start");
      Pause = false;
      inputString = "";

      return 1;

    }

  }
}

void SetSpeed()
{
  int DirecSRotation = inputString.lastIndexOf('S');

  if (DirecSRotation > 0)
  {

    inputString.remove(inputString.length() - 1, 1);

    int val = inputString.toInt();
    Serial.println("Speed : " + inputString);
    inputString = "";
    // map digital value from [0, 1023] to [5, 100]
    // min speed = 5 and max speed = 100 rpm
    if ( speed_ != map(val, 0, 1023, 5, 100) )
    {
      speed_ = map(val, 0, 1023, 5, 100);
      stepper.setSpeed(speed_);

    }
  }
}


bool debounce()
{



  byte count = 0;
  for (byte i = 0; i < 5; i++) {
    if (Pause == true)
      count++;
    delay(10);
  }
  if (count > 2)  return 1;
  else           return 0;
}





void stepperA(int xw) {
  for (int x = 0; x < xw; x++) {
    switch (Steps) {
      case 0:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        break;
      case 1:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, HIGH);
        break;
      case 2:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
        break;
      case 3:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, HIGH);
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
        break;
      case 4:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, HIGH);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
      case 5:
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, HIGH);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
      case 6:
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
      case 7:
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        break;
      default:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
    }

    SetDirection();
  }
}
void SetDirection() {
  if (Direction == 1) {
    Steps++;
  }
  if (Direction == 0) {
    Steps--;
  }
  if (Steps > 7) {
    Steps = 0;
  }
  if (Steps < 0) {
    Steps = 7;
  }
}

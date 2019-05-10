
//{ ============================================
//  Software Name : 	ESP32LED
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }

// Load Wi-Fi library from "Arduino core for the ESP32"
#include <WiFi.h>


// Replace with your Owen network credentials
const char* ssid     = "";
const char* password = "";

// Set web server port number to port 80 (it's better to choice Port 80)
WiFiServer server(80);

// string Variable to store the HTTP request
String header;

// string variables to store the current output state
String output26State = "off";
String output27State = "off";

// Assign output variables to GPIO pins
const int output26 = 26;
const int output27 = 27;

void setup() {
  Serial.begin(115200);//set the baudrate
  // Initialize the output variables as outputs
  pinMode(output26, OUTPUT);
  pinMode(output27, OUTPUT);
  // Set outputs to LOW
  digitalWrite(output26, LOW);
  digitalWrite(output27, LOW);

  // Connect to Wi-Fi network with SSID and password
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start Connection
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
}

void loop(){
  WiFiClient client = server.available();  
  if (client) {                            
    Serial.println("New Client.");          
    String currentLine = "";               
    while (client.connected()) {            
      if (client.available()) {           
        char c = client.read();           
        Serial.write(c);                    
        header += c;
        if (c == '\n') {                   
         
          if (currentLine.length() == 0) {     
            client.println("HTTP/1.1 200 OK"); // HTTP headers
            client.println("Content-type:text/html");// content-type
            client.println("Connection: close");
            client.println();         

         
            // turns the 2 LEDs on and off
            if (header.indexOf("GET /26/on") >= 0) {
              Serial.println("LED1 on");
              output26State = "on";
              digitalWrite(output26, HIGH);
            } else if (header.indexOf("GET /26/off") >= 0) {
              Serial.println("LED1 off");
              output26State = "off";
              digitalWrite(output26, LOW);
            } else if (header.indexOf("GET /27/on") >= 0) {
              Serial.println("LED2 on");
              output27State = "on";
              digitalWrite(output27, HIGH);
            } else if (header.indexOf("GET /27/off") >= 0) {
              Serial.println("LED2 off");
              output27State = "off";
              digitalWrite(output27, LOW);
            }
            
            // Display the HTML web page 
            //(you can change it however you want)
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            client.println("<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}");
            client.println(".button { background-color: #4CAF50; border: none; color: white; padding: 16px 40px;");
            client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
            client.println(".button2 {background-color: #555555;}</style></head>");
            
            // Web Page Heading
            client.println("<body><h1>ESP32LED</h1>");
            
            // Display current state, and ON/OFF buttons for LED1 
            client.println("<p>LED1 - State " + output26State + "</p>");
            // If the LED1 is off, it displays the ON button       
            if (output26State=="off") {
              client.println("<p><a href=\"/26/on\"><button class=\"button\">ON</button></a></p>");
            } else {
              client.println("<p><a href=\"/26/off\"><button class=\"button button2\">OFF</button></a></p>");
            } 
               
            // Display current state, and ON/OFF buttons for LED2 
            client.println("<p>LED2 - State " + output27State + "</p>");
            // If the LED2 is off, it displays the ON button       
            if (output27State=="off") {
              client.println("<p><a href=\"/27/on\"><button class=\"button\">ON</button></a></p>");
            } else {
              client.println("<p><a href=\"/27/off\"><button class=\"button button2\">OFF</button></a></p>");
            }
            client.println("</body></html>");
            
         
            client.println();
          
            break;
          } else { 
            currentLine = "";
          }
        } else if (c != '\r') {  
          currentLine += c;      
        }
      }
    }

    header = "";

    client.stop();
    Serial.println("Client disconnected...");
    Serial.println("");
  }
}



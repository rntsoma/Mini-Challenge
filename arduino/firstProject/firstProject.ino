#include <ESP8266WiFi.h>

//char ssid[] = "free_wifi";
//char pass[] = "12345qwe";
char ssid[] = "Workshop";
char pass[]="vnt@tws#";

void setupWifi();
void blinkLed();

int ledState = LOW;

unsigned long previousMillis = 0;
const long interval =1000;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  setupWifi();
  pinMode(0, OUTPUT);
  pinMode(2, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  blinkLed();
}

void blinkLed(){
// piscar led com bloqueio
// delay() faz o processador esperar, gastando processamento a toa
//  digitalWrite(0, LOW);
//  delay(1000);
//  digitalWrite(0, HIGH);
//  delay(1000);

// piscar led sem bloqueio

  unsigned long currentMillis = millis();
  //se nao for maior, o processador fica executando outro processo, nao havendo bloqueio
  if(currentMillis - previousMillis >= interval){
    previousMillis = currentMillis;
    if(ledState == LOW){
      Serial.println("Desligou o led");
      ledState = HIGH;
    }else{
      Serial.println("Ligou o led");
      ledState = LOW;
    }
    digitalWrite(0, ledState);
  }
}

void setupWifi(){
  Serial.println();
  Serial.print("Conectando ao SSID: ");
  Serial.println(ssid);

  WiFi.begin(ssid, pass);
  while(WiFi.status() != WL_CONNECTED){
    delay(500);
    digitalWrite(2, !digitalRead(2));
    Serial.print(".");
  }
  digitalWrite(2, LOW);
  Serial.println("\nConectado ao WiFi!");
  Serial.print("Endereco IP: ");
  Serial.println(WiFi.localIP());
}


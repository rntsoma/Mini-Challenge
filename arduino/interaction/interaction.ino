#include "Adafruit_MCP9808.h"
#include <ArduinoJson.h>
#include <Wire.h>

//Alguns casos exemplos:
//{"status":0, "seta_led":"desligado", "pisca_led": 100}
//{"status":0, "seta_led":"ligado"}
//{"status":0, "seta_led":"desligado"}
//{"status":0,"pisca_led": 500}

Adafruit_MCP9808 sensor = Adafruit_MCP9808();

void analisaJsonSerial(String json);
void enviaJsonSerial();
void ligaLed(int porta);
void desligaLed(int porta);
void inverteLed(int porta);
void atualizaLed();

//led pode ser: 0-desligado, 1-ligado, 2-piscando

int ledState=0;
int intervaloPisca=1000;
int ultimoPisca=0;

void setup() {
  // put your setup code here, to run once:
  pinMode(0, OUTPUT);
  Serial.begin(115200);
  Serial.println("Ligando Arduino...");
  if(!sensor.begin()){
    Serial.println("Sensor nao encontrado");
    while(1);
  }
  sensor.shutdown_wake(0);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available()){
    String txt = Serial.readStringUntil('\n');
    analisaJsonSerial(txt);
  }
  atualizaLed();
}

void analisaJsonSerial(String json){
  StaticJsonBuffer<200> jsonBuffer;
  JsonObject& buffer = jsonBuffer.parseObject(json);
  
  if(!buffer.success()){
    Serial.println("Json com erros");
    return;
  }
  
  if(buffer.containsKey("seta_led")){
    String set = buffer["seta_led"];
    if(set == "desligado"){
      ledState=0;
    }else if(set == "ligado"){
      ledState=1;
    }
  }

  if(buffer.containsKey("pisca_led")){
    ledState=2;
    intervaloPisca=buffer["pisca_led"];
  }

  if(buffer.containsKey("status")){
    enviaJsonSerial();
  }
}

void atualizaLed(){
  switch(ledState){
    case 0:
      desligaLed(0);
      break;
    case 1:
      ligaLed(0);
      break;
    case 2:
      if(millis() - ultimoPisca > intervaloPisca){
        ultimoPisca=millis();
        inverteLed(0);
      }
      break;
    default:
      break;
  }
}

void ligaLed(int porta){
  digitalWrite(porta, LOW);
}

void desligaLed(int porta){
  digitalWrite(porta, HIGH);
}

void enviaJsonSerial(){
  String statusLampada = "";
  StaticJsonBuffer<200> jsonBuffer;
  JsonObject& buffer = jsonBuffer.createObject();
  
  //define a string de estado do led

  switch(ledState){
    case 0:
      statusLampada = "Desligado";
      break;
    case 1:
      statusLampada = "Ligado";
      break;
    case 2:
      statusLampada = "Piscando";
      break;
  }

  float temp = sensor.readTempC();
  delay(200);
  buffer["temperatura"] = temp;
  buffer["lampada"] = statusLampada;
  buffer.prettyPrintTo(Serial);
  Serial.println();
}

void inverteLed(int porta){
  digitalWrite(porta, !digitalRead(porta));
}

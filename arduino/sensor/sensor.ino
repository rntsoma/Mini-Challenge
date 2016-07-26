#include "Adafruit_MCP9808.h"
#include <Wire.h>

Adafruit_MCP9808 sensor = Adafruit_MCP9808();

void mostra_temperatura();

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(200);

  Serial.println("Ligando Arduino...");
  Serial.println();

  //inicializa comunicacao com o sensor de temperatura
  if(!sensor.begin()){
    Serial.println("Sensor nao encontrado!");
    while(1);
  }

  //inicializa o sensor
  sensor.shutdown_wake(0);
}

void loop() {
  // put your main code here, to run repeatedly:
  mostra_temperatura();
  delay(1000);
}

void mostra_temperatura(){
  float c = sensor.readTempC();
  delay(250);

  Serial.print("Temperatura: ");
  Serial.print(c);
  Serial.println(" °C");
}


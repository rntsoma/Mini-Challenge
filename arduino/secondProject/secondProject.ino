void ligaLed(int porta);
void desligaLed(int porta);

void setup() {
  // put your setup code here, to run once:
  pinMode(0, OUTPUT);
  Serial.begin(115200);
  delay(2000);
  Serial.println("Ligando Arduino...");
}

void loop() {
  // put your main code here, to run repeatedly:
  //Se existe conteudo na porta serial
  if(Serial.available()){
    String texto = Serial.readStringUntil('\n');
    if(texto == "ligar"){
      ligaLed(0);
    }else if(texto == "desligar"){
      desligaLed(0);
    }
    Serial.println(texto);
  }
}

void ligaLed(int porta){
  digitalWrite(porta, LOW);
}

void desligaLed(int porta){
  digitalWrite(porta, HIGH);
}


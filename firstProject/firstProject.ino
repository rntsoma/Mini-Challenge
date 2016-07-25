int ledState = LOW;

unsigned long previousMillis = 0;
const long interval =1000;

void setup() {
  // put your setup code here, to run once:
  pinMode(0, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  
//  digitalWrite(0, LOW);
//  delay(1000);
//  digitalWrite(0, HIGH);
//  delay(1000);

// piscar led sem bloqueio

  unsigned long currentMillis = millis();
  if(currentMillis - previousMillis >= interval){
    previousMillis = currentMillis;
    if(ledState == LOW){
      ledState = HIGH;
    }else{
      ledState = LOW;
    }
    digitalWrite(0, ledState);
  }
}

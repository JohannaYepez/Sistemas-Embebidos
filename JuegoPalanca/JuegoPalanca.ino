int bstart = 4; //botón start
void setup() {
  Serial.begin(9600);
  attachInterrupt(0, izquierda , RISING);
  attachInterrupt(1, derecha , RISING);
  pinMode(bstart, INPUT);
}

void loop() {
 if(digitalRead(bstart)==HIGH){
  Serial.print("32");
 } 
}
void izquierda(){
  Serial.print("30");
}
void derecha(){
  Serial.print("34");
}

#include <TimerOne.h>//librería

/*
   UTN FICA CIERCOM
   Nombre: Johanna Yépez
   Enviar por Cx Serial a proccesing el valor de dos
   conversores analogos.
*/
String conversor; //datos a enviar
int CAD1; //conversor 1
int CAD2; //conversor 2
void setup() {
  Serial.begin(9600); //inicio Cx Serial
  pinMode(12,INPUT); //pines conversor
  pinMode(11,INPUT);
  Timer1.initialize(2000000);//2 segundos
  Timer1.attachInterrupt(lectura); //metodo
}

void loop() {
}
void lectura(){ //método timer
  CAD1=analogRead(11); //leer los CAD
  CAD2=analogRead(12);
  conversor= String(CAD1)+"*"+String(CAD2); //unir los dos datos con separador
  Serial.print(conversor); //imprimir para enviar a Proccesing
}

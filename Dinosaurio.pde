/*
UTN FICA CIERCOM
 Nombre: Johanna Yépez
 Realizar el dinosaurio de GOOGLE usando la función vertex
 */
int x=0;
void setup() {
  // Definir el size.
  size(500, 500); // X e Y.
  // Color de fondo RGB.
  background(255);
}
// Genera la interfaz siempre.
void draw() {
  background(255);
    beginShape(); //iniciar figura
    stroke(0); //filos de color negro
    fill(0); //relleno de color negro
    //Vertices de la Figura
    vertex(60, 200-x); //inicio Cola
    vertex(60, 280-x);
    vertex(80, 280-x);
    vertex(80, 300-x);
    vertex(100, 300-x);
    vertex(100, 320-x);
    vertex(120, 320-x);
    vertex(120, 340-x);
    vertex(160, 340-x); //inicio pies
    vertex(160, 420-x);
    vertex(200, 420-x);
    vertex(200, 400-x);
    vertex(180, 400-x);
    vertex(180, 380-x);
    vertex(200, 380-x);
    vertex(200, 360-x);
    vertex(220, 360-x);
    vertex(220, 340-x);
    vertex(240, 340-x);
    vertex(240, 360-x);
    vertex(260, 360-x);
    vertex(260, 420-x);
    vertex(300, 420-x);
    vertex(300, 400-x);
    vertex(280, 400-x);
    vertex(280, 340-x); //fin pie
    vertex(300, 340-x);
    vertex(300, 320-x);
    vertex(320, 320-x);
    vertex(320, 300-x);
    vertex(340, 300-x);
    vertex(340, 240-x); //inicio mano
    vertex(360, 240-x);
    vertex(360, 260-x);
    vertex(380, 260-x);
    vertex(380, 220-x); 
    vertex(340, 220-x); //fin mano
    vertex(340, 180-x); //inicio cabeza
    vertex(400, 180-x);
    vertex(400, 160-x);
    vertex(360, 160-x);
    vertex(360, 140-x);
    vertex(440, 140-x);
    vertex(440, 80-x);
    vertex(420, 80-x);
    vertex(420, 60-x);
    vertex(300, 60-x);
    vertex(300, 80-x);
    vertex(280, 80-x);
    vertex(280, 180-x); //fin cabeza
    vertex(260, 180-x);
    vertex(260, 200-x);
    vertex(240, 200-x);
    vertex(240, 220-x);
    vertex(220, 220-x);
    vertex(220, 240-x);
    vertex(180, 240-x);
    vertex(180, 260-x);
    vertex(160, 260-x);
    vertex(160, 280-x);
    vertex(120, 280-x);
    vertex(120, 260-x);
    vertex(100, 260-x);
    vertex(100, 240-x);
    vertex(80, 240-x);
    vertex(80, 200-x);
    vertex(60, 200-x);
    endShape(); //terminar figura
    fill(255); // Relleno color blanco para el ojo del Dinosaurio
    rect(320, 80, 20, 20); //Ojo del Dinosaurio
}

/*
  UTN FICA CIERCOM
 Integrantes:
 - Herdoíza Adriana 
 - Tito Mateo
 - Yépez Johanna
 
 Diseño de una juego Atari en Processing con comunicación de Arduino
 Juego: Breakout
 Indicaciones:
 - Mover la Barra inferior para impedir que la pelota caiga
 - Tiene 3 vidas
 - A medida que avanza el nivel la velocidad de la pelota aumenta
 - Use el control para mover la barra
 - El juego termina cuando todos los bloques se rompen o pierde
 */
//Comunicación Arduino
import processing.serial.*;
import ddf.minim.*;

Serial port;
Minim breakout;
AudioPlayer play1;

int anchoP=400; //tamaño de la ventana
int altoP=600;
int score=0; //puntuación
int vidas=3; //vidas
String mensaje; //imprimir mensaje
int estado=0; //pause
int espacio=1; //pause

//Bloques
float bloqueX=0;
int espaciobloques=5; //espacios para bloques
int numerobloquesC=6; //matriz de bloques
int numerobloquesF=6;
int espacioJuego=20;
float anchobloque=(anchoP-(numerobloquesC-2)*espaciobloques)/numerobloquesC; //calculo ancho bloques
float altobloque=30; //alto bloques
color coloresbloques[]={color(255, 0, 0), color (255, 83, 0), color(255, 255, 120), color(100, 255, 10), color(20, 10, 255), color(56, 100, 255), color(255, 100, 0), color(255, 183, 100), color(255, 140, 80), color(0, 255, 0)};
color colorbloque = color(255, 120, 0); //colores 
ArrayList<Block> bloques = new ArrayList<Block>(); //objeto bloques

//Pelota
int anchopelota=16; //tamaño pelota
float inicioXP=random(anchoP); //posición pelota random
float inicioYP=altoP/2; //posición pelota
color colorpelota= color(0); //color pelota
boolean pierde=false; // condiciones pierde o gana
boolean gana=false;
Pelota Move= new Pelota(inicioXP, inicioYP, anchopelota, colorpelota); // objeto pelota

//Barra
int barraX=anchoP/2; //posicion barra
int barraY=altoP-50;
int barraalto=20; //tamaño barra
int barraancho=70;
color barracolor= color(0);
Block barra= new Block(barraX, barraY, barraancho, barraalto, barracolor);

//Cx Serial
char dato;
int x = 165;
int en = 1;
void setup() {
  
  breakout = new Minim(this);
  play1 = breakout.loadFile("breaksong.wav");
  
  if (en == 1){
  port = new Serial(this, "COM5", 2000000); //comunicación serial Arduino
  en = 0;
  }
  size(400, 600);
  background(255);
  setupBloques(); //método de bloques
}

void draw() {
  // para probar el sonido
  play1.play();
  //Para que siga tocnado varias veces.
  if (play1.isPlaying()) {
  } else {
    play1.rewind();
    play1.play();
  }
  background(255);
  if (port.available()>0) {
    dato=port.readChar();
  }
  if (espacio==1) { // validación pause
    fill(0);
    text ("Presiona espacio", 75, 400);
    text ("para empezar", 100, 425);
  }
  mover();
  dibujarbloques(); //inicio juego
  if (!pierde&&!gana) { // validación final juego
    if (estado== 1) { // pause
      fill(255);
      rect(100, 450, 200, 100);
      espacio=0; //empezar juego
      dibujarpelota(); //método pelota
    }
    dibujarbarra(); //método move barra
  }
  actualizarscore(false); //método puntuación
  dibujarTexto(); //método para mensajes
  if (vidas==0) dibujarPierde(); //validación sin vidas
}

void mover() {
  switch(dato) {
  case 'I':
    println("Izquierda");
    if (x >= 0) {
      x = x - 25;
      
    }
    dato = ' ';
    break;
  case 'D':
    println("Derecha");
    if (x <= 330) {
      x = x + 25;
      dato = ' ';
    }
    break;
  case 'S':
    println("Select");
    estado=1-estado; //pause
    dato = ' ';
    break;
  case 'R':
    println("Restart");
    setup();
    redraw();
    vidas=3;
    score=0;
    estado=0; //pause
    espacio=1; //pause
    dibujarpelota();
    pierde=false; // condiciones pierde o gana
    gana=false;
    dato = ' ';
    break;
  }
}


//Generar Bloques
void setupBloques() {
  for (int numeroF=0; numeroF<numerobloquesF; numeroF++) { //fila bloques
    for (int numeroB=0; numeroB<numerobloquesC; numeroB++) { //columna bloques
      color colorbloque=coloresbloques[numeroF]; //colorear bloques
      float brickY= espacioJuego+(altobloque+espaciobloques)*numeroF; //posición bloque Y
      bloqueX=(anchobloque+espaciobloques)*numeroB; //posición en X
      bloques.add(new Block(bloqueX, brickY, anchobloque, altobloque, colorbloque)); //añadir método block
    }
  }
}

//Crear bloques
void dibujarbloques() {  
  for (int numeroB= bloques.size()-1; numeroB>=0; numeroB--) {
    Block bloque=bloques.get(numeroB);
    bloque.draw();
    if (bloque.collidesWith(Move)) {
      bloques.remove(bloque);
      actualizarscore(true);
    }
  }
}

//Movimiento pelota
void dibujarpelota() {
  Move.draw();
  Move.actualizar();
  if (Move.checkWallCollision()) {
    vidas--;
    Move.move(width/2, height/2);
  }
}

//dibujar la barra y  moverla con el mouse
void dibujarbarra() {
  barra.draw();
  barra.blockX=x;
  barra.collidesWith(Move);
}

//mostrar texto
void displayText(String mensaje, int x, int y, boolean isCentered) { 
  fill(0); //rellenar 
  textSize(32); //tamaño de texto
  String nombre= mensaje; //guardar mensaje
  float textoX= x; //posición texto X
  if (isCentered) { //Validación centro
    float anchotexto= textWidth(nombre); //tamaño de texto
    textoX= (width-anchotexto)/2; //cambiar posición X
  } 
  int textoY= y; //posición texto Y
  text(nombre, textoX, textoY); //escribir texto
}

void dibujarPierde() { //perder
  String mensaje="Perdiste!"; // declarar mensaje
  displayText(mensaje, 0, height/2, true); //enviar al método de mensaje
  pierde=true; //cambiar estado 
  text ("Reiniciar Enter", 100, 400); //imprimir exto de reinicio
}

//actualizar Score
void actualizarscore(boolean isNew) { //actualizar puntuación
  if (isNew) score+=10; //aumentar puntuación
  mensaje="Puntos:"+score; //imprimir mensaje
  displayText(mensaje, 0, height-2, false); //enviar al método de impresión
  if (score==numerobloquesC*numerobloquesF*10) { //validar score
    displayText("Ganaste!", 0, height/2, true); //enviar al método de impresión
    gana=true; //cambiar al estado de ganar
    text ("Reiniciar ESC", 100, 400); //imprimir un texto
  }
}

//validar vidas
void checkvidas() {
  if (Move.ballY+Move.ballancho==height) {
    vidas--;
  }
  dibujarTexto();
}

void dibujarTexto() {
  String mensaje;
  mensaje="Vidas: " + vidas;
  displayText(mensaje, ((int)(width-textWidth(mensaje))), height-2, false);
}

/*******Clase Pelota**************/
/* Modos de la Clase
 * Función constructora: para crear una nueva bola llamada:
 Pelota NombrePelota= new Pelota(x, y, Ancho, Color);
 * ballName.draw();  //dibuja la pelota
 * ballName.update(); //movimiento de la pelota
 * ballName.checkWallCollision(); //choque con la pelota
 */
class Pelota {
  float ballX;
  float ballY;
  float ballancho;
  color ballColor;
  float speedY= 3.5;
  float speedX= 3.5;

  //Función inicial
  Pelota(float x, float y, int ancho, color Color) {
    ballX= x;
    ballY= y;
    ballancho= ancho;
    ballColor= Color;
  }
  //Mover pelota
  void draw() {
    noStroke();
    fill(ballColor);
    ellipse(ballX, ballY, ballancho, ballancho);
  }


  //Cambio de velocidad;
  void actualizar() {
    ballX+=speedX;
    ballY+=speedY;
  }
  void move(int X, int Y) {
    ballX = X;
    ballY = Y;
    speedY= 4;
    speedX= 4;
  }

  //rebote en la barra
  boolean checkWallCollision() {
    if (ballX>width-ballancho/2) {
      speedX=-abs(speedX);
    } else if (ballX<ballancho/2) {
      speedX=abs(speedX);
    } 
    if (ballY>height-ballancho/2) { 
      speedY=-abs(speedY);
      return true;
    } else if (ballY<ballancho/2) {
      speedY= abs(speedY);
    }
    return false;
  }
}

/*******Clase Block**************/
/* Modos de la clase
 Block blockName= new Block(x, y, Width, Height, Color);
 * blockName.draw();  //Dibujo de bloques
 * blockName.move(x, y); //mueve al centro
 * blockName.collidesWith(Ball b); //Colisión con bloques
 *                                 //y rebote
 * blockName.setHits(int numberOfHits); //establecer el número de veces que un ladrillo necesita golpear
 * blockName.getHits(); //golpear el ladrillo que queda.
 */
class Block {
  float blockX;
  float blockY;
  float blockancho;
  float blockalto;
  color blockColor;
  int maxHits= 1;
  int hits=maxHits;

  //Función inicial
  Block(float x, float y, float ancho, float alto, color Color) {
    blockX= x;
    blockY= y;
    blockancho= ancho;
    blockalto= alto;
    blockColor= Color;
  }
  //dibujo de los bloques
  void draw() {
    noStroke();
    fill(blockColor);
    rect(blockX, blockY, blockancho, blockalto);
  }


  //this moves the block 
  //to be centered on X, Y coordinates
  void move(int X, int Y) {
    blockX=X-blockancho/2;
    blockY=Y-blockalto/2;

    //Evita que salga de la pantalla en la dirección X
    if (blockX+blockancho>width) {
      blockX=width-blockancho;
    } else if (blockX<0) {
      blockX=0;
    }

    //Evita que salga de la pantalla en la dirección Y
    if (blockY+blockalto>height) {
      blockY=height-blockancho;
    } else if (blockY<0) {
      blockY=0;
    }
  }

  //permite cambiar la cantidad de veces que se puede golpear un bloque individual
  void setMaxHits(int numberOfHits) {
    maxHits=numberOfHits;
    hits= maxHits;
  }

  //permite aumentar el numero de hits
  int getHits() {
    return hits;
  }
  // devuelve un booleano si choca con una pelota.
  // Cambia automáticamente la velocidad de la pelota.
  boolean collidesWith(Pelota b) {
    //choca con la parte inferior del bloque
    if ((b.ballX+b.ballancho/4>blockX && b.ballX-b.ballancho/4<blockX+blockancho)
      && (b.ballY-b.ballancho/2<(blockY+blockalto) && b.ballY-b.ballancho/2>blockY)) {
      b.speedY=abs(b.speedY);
      hits--;
      return true;
    }

    //choca con la parte superior del bloque
    if ((b.ballX+b.ballancho/4>blockX && b.ballX-b.ballancho/4<blockX+blockancho)
      && (b.ballY+b.ballancho/2<blockY+blockalto && b.ballY+b.ballancho/2>blockY)) {
      b.speedY=-abs(b.speedY);
      hits--;
      return true;
    }

    //Choca con el lado izquierdo del bloque.
    else if ((b.ballY+b.ballancho/4>blockY && b.ballY-b.ballancho/4<blockY+blockalto)
      && (b.ballX+b.ballancho/2>blockX && b.ballX+b.ballancho/2<blockX+blockancho)) {
      b.speedX=-abs(b.speedX);
      hits--;
      return true;
    }

    //Choca con el lado derecho del bloque.
    if ((b.ballY+b.ballancho/4>blockY && b.ballY-b.ballancho/4<blockY+blockalto)
      && (b.ballX-b.ballancho/2<blockX+blockancho && b.ballX-b.ballancho/2>blockX)) {
      b.speedX=abs(b.speedX);
      hits--;
      return true;
    }
    return false;
  }
}

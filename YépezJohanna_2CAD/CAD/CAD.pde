/*
  UTN FICA CIERCOM
 Nombre: Johanna Yépez
 Interfa con botón de conexión para puerto Serial
 2 Sliders que van cambiando de valor y color de acuerdo al CAD
 Se recibe datos separados por * 
 CAD1*CAD2
 */
import controlP5.*; //Librería de botones
import processing.serial.*; //librería de puerto Serial
Serial port; //objetos de librerías
ControlP5 cp5;
int CX=0;
String conversor, CAD1, CAD2;
int CAD1valor, CAD2valor;
int in;

void setup() {
  size(1200, 900); //tamaño ventana
  background(255); //color fondo
  cp5 = new ControlP5(this); //Nuevo objeto

  cp5.addButton("CONEXION") //botón de conexión
    .setPosition(50, 50)
    .setSize(200, 100);

  cp5.addSlider("CAD1") //contenedor 2
    .setPosition(200, 300)
    .setSize(50, 400)
    .setColorBackground(color(139, 0, 255))
    .setColorForeground(color(112, 64, 152))
    .setRange(0, 255)
    .setNumberOfTickMarks(255);

  cp5.addSlider("CAD2") //contenedor 2
    .setPosition(600, 300)
    .setSize(50, 400)
    .setNumberOfTickMarks(255)
    .setColorBackground(color(139, 0, 255))
    .setColorForeground(color(112, 64, 152))
    .setRange(0, 255);
}
void draw() {
  background(255); //color fondo
  textSize(20);
  fill(56, 67, 163);
  text("Contenedor 1", 250, 425);
  text("Contenedor 2", 650, 425);
  text("Cantidad:", 250, 450);
  text(str(CAD1valor), 350, 450);
  text("Cantidad:", 650, 450);
  text(str(CAD2valor), 750, 450);
  if (CX==1) {
    if (port.available()>0) {
      conversor=port.readString();
      try {
        in=conversor.indexOf("*"); //almacenar el separador
        if (in <= 0) //validar
          in = 1;
        CAD1 = conversor.substring(0, in); //almacenar primer dato desde la primera posición hasta el separador
        CAD2 = conversor.substring(in+1, conversor.length()); //almacena segundo valro desde la posicion del separador hasta el tamaño del String
        CAD1valor = int(CAD1)/2; //Convertimos a ENTERO y dividimos para normalizar datos
        CAD2valor = int(CAD2)/2;
      } 
      catch (StringIndexOutOfBoundsException e) { //si hay errores regresa a 1
        CAD1valor=1;
        CAD2valor=1;
      }
      //Contenedor 1
      if (CAD1valor<=80) { //Rango de color Rojo
        cp5.getController("CAD1").setValue(CAD1valor); // Cambiar el valor en contenedor
        cp5.getController("CAD1").setColorForeground(color(255, 0, 0));
      } else if (CAD1valor>80&& CAD1valor<=160) { //Rango Color Verde
        cp5.getController("CAD1").setValue(CAD1valor); // Cambiar el valor en contenedor
        cp5.getController("CAD1").setColorForeground(color(0, 255, 0)); 
      }else if (CAD1valor>160) { //Rango Color Azul
        cp5.getController("CAD1").setValue(CAD1valor); // Cambiar el valor en contenedor
        cp5.getController("CAD1").setColorForeground(color(0, 0, 255)); 
      }
      //Contenedor 2
      if (CAD2valor<=80) { //Rango de color Rojo
        cp5.getController("CAD2").setValue(CAD2valor); // Cambiar el valor en contenedor
        cp5.getController("CAD2").setColorForeground(color(255, 0, 0));
      } else if (CAD2valor>80&& CAD2valor<=160) { //Rango Color Verde
        cp5.getController("CAD2").setValue(CAD2valor); // Cambiar el valor en contenedor
        cp5.getController("CAD2").setColorForeground(color(0, 255, 0)); 
      }else if (CAD2valor>160) { //Rango Color Azul
        cp5.getController("CAD2").setValue(CAD2valor); // Cambiar el valor en contenedor
        cp5.getController("CAD2").setColorForeground(color(0, 0, 255)); 
      }
    }
  }
}

void CONEXION() {
  CX= 1- CX;
  if (CX==1) { //conectado
    port = new Serial(this, "COM5", 9600);
    cp5.getController("CONEXION").setLabel("CONECTADO");
    cp5.getController("CONEXION").setColorBackground(color(136, 232, 6));
    println("Conectado");
  } else { //desconectado
    port.stop();
    cp5.getController("CONEXION").setLabel("DESCONECTADO");
    cp5.getController("CONEXION").setColorBackground(color(255, 0, 0));
  }
}

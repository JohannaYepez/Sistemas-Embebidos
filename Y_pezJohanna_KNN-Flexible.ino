#include "datos.h"
/*
   UTN FICA CIERCOM
   Nombre: Johanna Yepez
   Deber #1
      KNN flexible
*/
int col; //declarar variables
int fila = 0;
float datos_entrada[5] = {5.5, 4.2, 1.4, 0.2, 1}; //datos de prueba
float prom;
float dist;
int k = 3; //declarar k
float dist_menor[2][3]; //declarar matriz para almacenar datos
int i = 0;
int j = 0;
float aux; //variables auxiliares
int aux1;
int seto; //contador de etiquetas
int versi;
int virgi;
void setup() {
  Serial.begin(9600);
  for (; i < k; i++) { //llenar matriz con datos knn
    dist_menor[0][i] = 4000 + i;
    dist_menor[1][i] = 0;
  }
  i = 0;
}

void loop() {
  for (; fila < 90; fila++) { //leer matriz de 90 datos
    for (col = 0; col < 4; col++) {
      prom = prom + (pow(datos_entrada[col] - matriz[fila][col], 2)); //sumatoria
    }
    dist = sqrt(prom); //raiz cuadrada de la sumatoria
    prom = 0;
    if (dist < dist_menor[0][k - 1]) { //comparar distancias
      dist_menor[0][k - 1] = dist;
    }
    for (; i < k; i++) { //ordenar matriz
      for (j = i + 1; j < k; j++) {
        if (dist_menor[0][i] > dist_menor[0][j]) {
          aux = dist_menor[0][i];
          dist_menor[0][i] = dist_menor[0][j];
          dist_menor[0][j] = aux;
          //etiquetas
          aux1 = dist_menor[1][i];
          dist_menor[1][i] = dist_menor[1][j];
          dist_menor[1][j] = aux1;
        }
      }
    }
    i = 0;
    for (; i < k; i++) { //escoger al más cercano
      if (dist_menor[1][i] == 1.00) { //contador para etiqueta 1
        seto++;
      }
      if (dist_menor[1][i] == 2.00) { //contador para etiqueta 2
        versi++;
      }
      if (dist_menor[1][i] == 3.00) { //contador para etiqueta 3
        virgi++;
      }
    }
    if (seto > versi && seto > virgi) //validar caso etiqueta 1
      Serial.println("Iris-setosa");
    if (versi > seto && versi > virgi) //validar caso etiqueta 2
      Serial.println("Iris-versicolor");
    if (virgi > versi && virgi > seto) //validar caso etiqueta 3
      Serial.println("Iris-virginica");
  }
}

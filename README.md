# Processing Shaders y OpenCV

## Sobre el Autor

> **Miguel Lincoln Capote Pratts** - Universidad de Las Palmas de Gran Canaria [**ULPGC**](https://www.ulpgc.es).

![](peek.gif)

## Desarrollo

La idea de este proyecto es captar el rostro mediante OpenCV y posteriormente taparlo utilizando ruido generado por un shader.

El desarrollo se realizó en Ubutu
 por ello fue necesario añadir una libreria
 de `video` distinta a la que ofrece processing
 por defecto. La librería es [Video Library
](https://github.com/processing/processing-video) y para añadirla a processing
 es necesario hacer una [instalación manual](https://github.com/processing/processing/wiki/How-to-Install-a-Contributed-Library).

Se hace uso de la librería de `Video` mencionada con anterioridad para capturar la `Cam` y con ello una imagen la cual es procesada por `OpenCV` para detectar la cara. Una vez se detecta la cara se envía la información al shader el cual aplica ruido solo en la zona enviada, es decir, en el rostro. Existieron varias complicaciones a la hora de programar el shader; por una parte la imagen salía boca abajo y se optó por invertir el eje y (1 - y), por otro lado solo se hace el efecto solo la primera cara que detecta y no en todas por que no se pudo encontrar una forma de pasar arrays a los shaders.



## Referencias y Librerías utilizadas

Se desarrollo
 utilizando como referencia la página oficial de processing. 
 
[Ejemplos The Book of Shaders](https://thebookofshaders.com/examples/?chapter=11)

[CVImage library](http://www.magicandlove.com/blog/2018/11/22/opencv-4-0-0-java-built-and-cvimage-library/)
<br>
[Video Library](https://github.com/processing/processing-video)

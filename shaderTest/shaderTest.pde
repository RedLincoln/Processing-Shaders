import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
//Detectores
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;

Capture cam;
CVImage img;
PShader sh;

//Cascadas para detección
CascadeClassifier face,leye,reye, mouth;
//Nombres de modelos
String faceFile, leyeFile,reyeFile, mouthFile, glassesFile, moustacheFile, topHatFile;
//PShape filters

void setup() {
  size(640, 480, P3D);
  //Cámara
  cam = new Capture(this, width , height);
  cam.start(); 
  
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);
  
  //Detectores
  faceFile = "haarcascade_frontalface_default.xml";
  face = new CascadeClassifier(dataPath(faceFile));
  
  sh = loadShader("noise-faces.glsl");
}



void draw() {  
  if (cam.available()) {
    background(0);
    cam.read();
    
    
    //Imagen de entrada
    
    image(cam,0,0);
    
    blurFace();
  }
  //shader(sh);
}

void blurFace()
{
  img.copy(cam,0,0,cam.width,cam.height,0,0,img.width,img.height);
  img.copyTo();
  
  //sh.set("u_resolution", float(width), float(height));
  
  image(img, 0, 0);
  
  Mat grey = img.getGrey();
  
  MatOfRect faces = new MatOfRect();
  face.detectMultiScale(grey, faces,1.15,3,Objdetect.CASCADE_SCALE_IMAGE, new Size(60,60),new Size(200,200));
  Rect [] facesArr = faces.toArray();
  grey.release();
  faces.release();
  
  if (facesArr.length > 0){
    sh.set("u_resolution", float(width), float(height));
    sh.set("u_time", millis() / 1000.0);
    sh.set("u_position", float(facesArr[0].x), float(facesArr[0].y));
    sh.set("u_dimension", float(facesArr[0].width / 2), float(facesArr[0].height));
    sh.set("inputTexture", img);
    shader(sh);
    
  }else{
    resetShader();
  }
  /*
  if(facesArr.length > 0){
    float xPos = float(facesArr[0].x + facesArr[0].width/2);
    float yPos = float(facesArr[0].y);
    sh.set("u_position",xPos,yPos);
    filter(sh);
  }else resetShader();
  */
}

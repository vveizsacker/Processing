/* autogenerated by Processing revision 1283 on 2023-02-01 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class main extends PApplet {

ArrayList<Collider> colliders = new ArrayList<Collider>();
ArrayList<Ray> rays = new ArrayList<Ray>();
float angle = .01f;

 public void setup(){
  /* size commented out by preprocessor */;
  Start();
}

 public void draw(){
  background(0);
  Update();
  for(Collider c : colliders){
    noFill();
    stroke(255,0,0);
    line(c.x,c.y,c.x + c.sx,c.y + c.sy);
  }
}

 public void Start(){
  createRays();
  createColliders();
}

 public void Update(){
  for(Ray ray : rays)for(Collider c : colliders){
    ray.x = mouseX; 
    ray.y = mouseY;
    if(CheckCollision(ray,2000,c))
    ray.drawLine();
  }
}

 public boolean CheckCollision(Ray ray,float range,Collider c){
  float x1 = c.x;
  float x2 = c.x + c.sx;
  float x3 = ray.x;
  float x4 = ray.dx * range;
  float y1 = c.y;
  float y2 = c.y + c.sy;
  float y3 = ray.y;
  float y4 = ray.dy * range;
  
  float d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 -x4);
  float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / d;
  float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / d;
  
  if( t > 0 && t <1 && u > 0){
    return true; 
  }
  return false;
}

 public void createRays(){
  for(float a = 0;a < 3*PI; a+=angle){
    float dx = width * cos(a);
    float dy = width * sin(a);
    Ray ray = new Ray(mouseX,mouseY,dx,dy);
    rays.add(ray);
  } 
}

 public void createColliders(){
  for(int i = 0 ; i < 5 ; i++){
    float x = random(0,width-100);
    float y = random(0,height-100);
    Collider c = new Collider(x,y,100,100);
    colliders.add(c);
  }
}
class Collider{
  float x,y;
  float sx,sy;
  
  public Collider(float x,float y,float sx,float sy){
    this.x = x;
    this.y = y;
    this.sx = sx;
    this.sy = sy;
  }
  
}
class Ray{
  float x,y;
  float dx,dy;
  float len = 2000;
  
  public Ray(float x,float y,float dx,float dy){
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
  }
  
   public void drawLine(){
    stroke(255);
    line(x,y,dx*len,dy*len);
  }
}


  public void settings() { size(800, 600); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
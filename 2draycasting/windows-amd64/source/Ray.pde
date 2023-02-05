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
  
  void drawLine(){
    stroke(255);
    line(x,y,dx*len,dy*len);
  }
}

float hexagonSize;
int gap = 50;
int radius;
Hex[][] hexGrid;

//float gap = 100; 100 * (gap/100)
float x = 0;
float y = 0;

void setup(){
  size(600,600);
  radius = 30;
  hexGrid = new Hex[width/radius][height/radius];
  
   for(int i = 0; i<width/radius;i++){
     for(int j = 0; j<height/radius;j++){
       
       hexGrid[i][j] = new Hex(x,y,radius);
       print(i);
       println(j);
       x+=radius * sqrt(3);
     }
     y += (radius * 3)/2;
     if((i+1)%2==0) x = sqrt(3)*radius;
     else x = int(radius * sqrt(3)/2);
   }
   //hexGrid[0][0].SetColor();
}


void draw(){
  background(0);

  for(int i = 0;i<width/radius;i++){
    for(int j = 0; j<height / radius;j++){
      hexGrid[i][j].Draw();  
    }
  }
    

}
void resetGrid(){
  
}
void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      
    }
  }
}
PVector position = new PVector(5,5);
void Move(PVector dir){
  position.x += dir.x;
  position.y += dir.y;
  
}


class Hex{
  float x;
  float y;
  float radius;
  float angle = TWO_PI / 6;
  boolean marked = false;
  
  public Hex(float x,float y,float radius){
     this.x = x;
     this.y = y;
     this.radius = radius;
  }
  void SetColor(){
    marked = true;
  }
  void Draw(){
      beginShape();
      
      for(float a = PI/6; a < TWO_PI; a+= angle){
        float vx = this.x + cos(a) * radius;
        float vy = this.y + sin(a) * radius;
        vertex(vx,vy);
      }
      if(marked)fill(255,0,0);
      endShape(CLOSE);
  }
}

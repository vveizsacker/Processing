int cellSize = 50;
int n = 11;
float posX = 0;
float posY = 0;
void setup(){
  size(600,600);  
}

void draw(){
  background(0);
  createTri();
}
int fact(int x){
  int s = 1;
  for(int i = 1;i<=x;i++) 
    s *= i;
  return s;
}

void createTri(){
  for(int i = 0; i< n;i++)for(int j = 0; j<n;j++){
      if(i<=j){
        
      posX = (width - ((j)*cellSize)) / 2;
      //posY = height/2 - ((n-j-1)*cellSize)/2;
      posY = cellSize;
      
      CreateHex(i*cellSize + posX,j*cellSize + posY);
      int z = fact(j) / (fact(j-i) * fact(i));
      text(z,i*cellSize + posX,j * cellSize + posY);
      textSize(16);
      textAlign(CENTER,CENTER);
      fill(255);
      }
    
  }
}

void CreateHex(float x,float y){
  stroke(255);
  noFill();
  beginShape();
  for(float i = PI/6; i < TWO_PI;i+=TWO_PI/6){
    float hx = x + cos(i) * cellSize/2 ;
    float hy = y + sin(i) * cellSize/2 ;
    vertex(hx,hy);
  }
  
  endShape(CLOSE);
}

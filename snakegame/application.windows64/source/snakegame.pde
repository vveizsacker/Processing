int blockSize = 25;

int fps = 10;
int speed = 1;

Snake head;
PVector direction = new PVector(1,0);
PVector apple;

ArrayList<Snake> snake = new ArrayList<Snake>();


void setup(){
  init();
  frameRate(fps);
  size(500,500);
}

void draw(){
  background(0);  
  DrawGrid();
  
  
  PVector nextPosition = new PVector(head.getPosition().x+direction.x*blockSize,head.getPosition().y+direction.y*blockSize);
  head.setPosition(nextPosition);
  
  if(CheckCollision()){
    Eat(); 
    pickNewLocation();
  }
  updateTail();
  
  rect(apple.x,apple.y,blockSize,blockSize);
  for(int i = 0;i<snake.size();i++){
    snake.get(i).draw();
    System.out.println(snake.get(i).getPosition());
  }
  head.draw();
  System.out.println(snake.size());
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
       direction.set(0,-1);
    } 
    else if (keyCode == DOWN) {
      direction.set(0,1);
    } 
    else if (keyCode == RIGHT) {
      direction.set(1,0);
    } 
    else if (keyCode == LEFT) {
      direction.set(-1,0);
    } 
  } 
}
void pickNewLocation(){
    apple = new PVector(int(random(0,width/blockSize)),int(random(0,height/blockSize))).mult(blockSize);
}
void init(){
  pickNewLocation();
  head = new Snake(new PVector(width/2,height/2));
  snake.add(head);
}

void DrawGrid(){
  for(int i = -1;i<width/blockSize;i++){
    for(int j = -1;j<height/blockSize;j++){
      line(i*blockSize,j*blockSize,(i+1)*blockSize,j*blockSize);
      line(i*blockSize,(j+1)*blockSize,(i)*blockSize,j*blockSize);
      stroke(128);
    }  
  }
}

public boolean CheckCollision(){
  return dist(head.getPosition().x,head.getPosition().y,apple.x,apple.y)<.5f;
}

void Eat(){
  Snake tail = snake.get(snake.size()-1);
  Snake t = new Snake(tail.oldposition);
  snake.add(t);
}

void updateTail(){
  for(int i = 1;i<snake.size();i++){ 
    snake.get(i).setPosition(snake.get(i-1).oldposition);
    //if(i>0){snake.get(i).setPosition(snake.get(i-1).oldposition);}
  }
}

class Snake{
  PVector position;
  public PVector oldposition;
  color c;
  
  public void setColor(){
    c = color(255,0,0); 
  }
  
  void setRandomColor(){
    float r = random(255);
    float g = random(255);
    float b = random(255);
    c = color(r,g,b);
  }
  public PVector getPosition(){
    return position;
  }
  
  public void setPosition(PVector p){
    oldposition = position;
    position = p;
  }
  
  public Snake(PVector position){
    this.position = position;
    setRandomColor();
  }
  
  public void draw(){
    noStroke();
    rect(this.position.x,this.position.y,blockSize,blockSize);
    fill(c);
  }
}

    

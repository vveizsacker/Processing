ArrayList<Box> boxes = new ArrayList<Box>();
int boxAmount = 20;

float Time = 0;
float timestamp;
float updateRate = 5;


void setup(){
  size(600,600);
  for(int i =0;i<boxAmount;i++){
    Box box = new Box(new PVector(width/2,height/2),random(10,100));
    boxes.add(box);
  }
}

void draw(){
  background(0);
  for(Box b : boxes) b.Draw();
  Update();
}

void Update(){
  Time += .1;
  if(timestamp <= Time){
    timestamp = Time + random(1,updateRate);
    for(Box b : boxes) b.setDirection(new PVector(random(-1,1),random(-1,1)));
  }
  for(Box b : boxes) {
    b.Move();
    if(b.position.x > width) b.position.x = 0;
    if(b.position.x < 0 ) b.position.x = width;
    if(b.position.y > height) b.position.y = 0;
    if(b.position.y <0 )b.position.y = height;
  }
  for (int i =0;i<boxes.size();i++) for(int j=0;i<boxes.size();j++) {
    if(i==j){
      break;
    }
    else
      {
      if(CheckCollsion(boxes.get(i),boxes.get(j))) {
        stroke(255,0,0);
        line(boxes.get(i).position.x,boxes.get(i).position.y,boxes.get(j).position.x,boxes.get(j).position.y);
        println("collided");
      } 
      else{ 

        println("not collided");
      }
      }
  }
  
}

boolean CheckCollsion(Box a,Box b){
  float x1 = a.position.x;
  float y1 = a.position.y;
  float size1 = a.size;
  
  float x2 = b.position.x;
  float y2 = b.position.y;
  float size2 = b.size;
  
  //return (a.position.x < b.position.x + b.size && a.position.x + a.size > b.position.x && a.position.y < b.position.y + b.size && a.size + a.position.y > b.position.y);
  
 return (x1 < x2 + size2 && x1 + size1 > x2 && y1 < y2 + size2 && size1 + y1 > y2);
}

class Box{
  //public Collider collider;
  PVector position;
  PVector direction = new PVector(1,0);
  color c = color(0,255,0);
  float size = 50;
  
  public Box(PVector position,float size){
    //collider = new Collider();
    this.size = size;
    this.position = position;
  }
  void setDirection(PVector direction) {
    this.direction = direction; 
  }
  void Move(){
    this.position.add(direction); 
  }
  void changeColor(){
    c = color(255,0,0);
  }
  void resetColor(){
    c = color(0,255,0); 
  }
  void Draw(){
    stroke(c);
    noFill();
    rect(position.x,position.y,size,size); 
  }
}

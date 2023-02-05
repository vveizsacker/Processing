int fps = 60;
int screenWidth = 800;
int screenHeight = 600;

//PRIVATE VARS
  float timestamp;
  float time;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
//PARTICLE SYSTEM SETTINGS
  float lifeTime = 100;
  float size = 30;
  float speed = 2.5f;
  PVector direction = new PVector(0,-1);
  PVector startPosition;
  float spawnRate = 1;
  int maxParticlesCount = 10;
  int spawnParticlesCount=1;
  float gravity = 0;
  boolean randomizeColor = true;


void setup(){
  frameRate(fps);
  size(800,600);
  init();
}

void draw(){
  background(20);
  Update();
}

void init(){
  
}

void Update(){
  time++;
  System.out.println(time / fps);
  System.out.println(particles.size());
  
  if(timestamp <= time && particles.size()<=maxParticlesCount){
    timestamp = time + spawnRate; 
    
    for (int i = 0; i <= spawnParticlesCount;i++){
      Particle p = new Particle(lifeTime,size,random(1,speed),new PVector(random(-1,1),random(-1,1)),new PVector(random(0,width),random(0,height)));
      particles.add(p);
    }

  }
  
  for(int i = 0;i<particles.size();i++){
    particles.get(i).update();
    particles.get(i).draw();
    for (int j = 0;j<particles.size();j++){
      if(i != j ){
        stroke(255);
        line(particles.get(i).position.x,particles.get(i).position.y,particles.get(j).position.x,particles.get(j).position.y);
      }
    }
  }
  
  for(int i = particles.size()-1;i>0;i--){
    if(particles.get(i).getLifeTime() <= 0 || particles.get(i).alpha <= 0){
       particles.remove(i);
    }
  }
  
}


class Particle{
  float size;
  float speed;
  float lifeTime; public float getLifeTime(){return lifeTime;}
  PVector direction;
  PVector position;
  PVector velocity;
  
  color c = color(255);
  public int alpha = 255;
  
  public Particle(float lifeTime,float size,float speed,PVector direction,PVector position){
    this.lifeTime = lifeTime;
    this.size = size;
    this.speed = speed;
    this.direction = direction.mult(this.speed);
    this.position = position;
    if(randomizeColor)setRandomColor();
  }
  
  void setRandomColor(){
    float r = random(255);
    float g = random(255);
    float b = random(255);
    c = color(r,g,b);
  }
  void draw(){
    circle(position.x,position.y,size);
    noStroke();
    fill(c,alpha);
  }
  
  void update(){
    lifeTime--;
    velocity = direction;
    velocity.y += gravity*.1f;
    //if(size > 0) size -= 2 * .1f;
    if(alpha > 0)alpha -= 20*.1f;
    position.set(position.add(velocity)); 
  }
  
}

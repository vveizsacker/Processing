PVector gridSize = new PVector(12,20);

float speed = .2;
float Time = 0;
float timestamp = 0;

boolean running = true;

int blockSize = 30;
Block[] piece = new Block[4];

PVector spawnPoint;
ArrayList<Block> totalBlocks = new ArrayList<Block>();

int[][] figures = new int [][]{
  {1,3,5,7},
  {2,4,5,7},
  {3,5,4,6},
  {3,5,4,7},
  {2,3,5,7},
  {3,5,7,6},
  {2,3,4,5}
};

int currentPiece;
int nextPiece;

void setup(){
  size(600,600);
  spawnPoint = new PVector((gridSize.x*blockSize) / 2,0);
  nextPiece = int(random(0,6));
  spawnNewPiece();
}

void draw(){
  background(0);
  createUI();
  Update();
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == DOWN){
      rotatePiece();
    }
    if(keyCode == RIGHT){
      movePiece(new PVector(blockSize,0)); 
    }
    if(keyCode == LEFT){
      movePiece(new PVector(-blockSize,0)); 
    }
  }
}

void Update(){
  if(!running) return;
  
  Time+=.02;
  if(timestamp <= Time){
    timestamp = Time + speed;
    movePiece(new PVector(0,blockSize));
  }
  drawGrid();
  drawPiece();
  for(Block b : totalBlocks)
    b.Draw(); 
}

void createUI(){
  fill(255);
  textSize(17);
  text("Next Piece",blockSize*2 + gridSize.x * blockSize,blockSize);
  
  for(int i = 0;i<4;i++){   
    fill(255);
    PVector p = new PVector(figures[nextPiece][i] % 2*blockSize,figures[nextPiece][i] / 2*blockSize);
    rect(p.x +blockSize*3 + gridSize.x * blockSize,p.y + blockSize*1.5 , blockSize,blockSize);
  }
}

void spawnNewPiece(){
  if(!running) return;
  currentPiece = nextPiece;
  nextPiece = int(random(0,6));
  
  createPiece(currentPiece);    
  for(int i = 0;i<4;i++){
    piece[i].SetPosition(spawnPoint);
  }
}

void createPiece(int index){
  color c = color(0,255,0);
  
  for(int i = 0;i<4;i++){   
    fill(c);
    PVector p = new PVector(figures[index][i] % 2*blockSize,figures[index][i] / 2*blockSize);
    Block b = new Block(p,c); 
    piece[i] = b;
  }
}
void drawPiece(){
  for(int i = 0;i<4;i++){
    piece[i].Draw(); 
  }
}
void drawGrid(){
  for(int i = 0;i<=gridSize.x;i++) for(int j = 0;j<=gridSize.y;j++){
    stroke(128);
    line(i*blockSize ,j*blockSize ,(i+1)*blockSize,j*blockSize); 
    stroke(128);
    line(i*blockSize,j*blockSize,i*blockSize ,(j+1)*blockSize); 
  }
}

void movePiece(PVector direction){
  if(CheckLegalMove(direction)) return;
  if(CheckBounds(direction)) return;
  if(CheckBlocksCollision(direction)) return;
  for(int i = 0;i<4;i++){
    piece[i].Move(direction);
  }
}
boolean CheckLineSequence(int line){
  ArrayList<Block> blocks = new ArrayList<Block>();
  for(Block b : totalBlocks){
    if(b.position.y == line*blockSize) blocks.add(b);
  }
  if(blocks.size() == gridSize.x) {
    for(int i = 0;i<gridSize.x;i++)
      totalBlocks.remove(blocks.get(i));
    return true;
  }
  return false; 
}

void checkSequence(){
  for(int i = 0; i< gridSize.y;i++){
    if(CheckLineSequence(i))
      for(Block b : totalBlocks){
        if(b.position.y < i * blockSize){
          b.Move(new PVector(0,blockSize)); 
        }
      }
  }
}
boolean CheckFailure(){
  for(int i = 0;i < 4 ;i++){
    if(piece[i].position.y == 4 * blockSize) return true; 
  }
  return false;
}
void freezPiece(){
  for(int i = 0;i<4;i++)
    totalBlocks.add(piece[i]); 
    
  if(CheckFailure()){
    for(Block b : totalBlocks)
      b.c = color(255,0,0);
    endGame();
  }
  checkSequence();
}

void rotatePiece(){
  Block center = piece[1];
    
  for(int i = 0;i<4;i++){
    float x = piece[i].position.y - center.position.y;
    float y = piece[i].position.x - center.position.x;
    piece[i].position.x = center.position.x - x;  
    piece[i].position.y = center.position.y+y;  
  }
}
boolean CheckLegalMove(PVector direction){
  for(int i = 0; i<4;i++) for(Block c : totalBlocks)
    if(piece[i].position.x + direction.x == c.position.x && piece[i].position.y == c.position.y) return true;
  return false; 
}
boolean CheckBlocksCollision(PVector direction){
  for(int i = 0;i <4 ;i++) for(Block c : totalBlocks){
    if(piece[i].position.y + direction.y == c.position.y && piece[i].position.x == c.position.x) {
      freezPiece();
      spawnNewPiece();
      return true;
    }
  }
  return false; 
}
boolean CheckBounds(PVector direction){
  for(int i = 0; i < 4 ; i++){
    if(piece[i].position.x + direction.x >= gridSize.x * blockSize  || piece[i].position.x + direction.x < 0) return true;
    if(piece[i].position.y + direction.y >= gridSize.y * blockSize) {
      freezPiece();
      spawnNewPiece();
      return true;
    }
  }
  return false; 
}

void endGame(){
  running = false;
}

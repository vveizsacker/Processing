class Block{
  PVector position;
  color c;
  
  public Block(PVector position ,color c){
    this.position = position;
    this.c = c;
  }
  void SetPosition(PVector pos){
    this.position.add(pos); 
  }
  void Move(PVector direction){
    this.position = this.position.add(direction);
  }
  void Draw(){
    fill(c);
    noStroke();
    rect(position.x,position.y,blockSize,blockSize);
  }
}

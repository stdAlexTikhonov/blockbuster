Block block;
Maxim maxim;
AudioPlayer player;
AudioPlayer player1;

int blocks;
boolean startMenu = true;
boolean button1 = false;
boolean button2 = false;
float ang1 = 0;
float ang2 = 0;
ArrayList blockCollection;

void setup(){
  size(400,400);
  frameRate(30);
  maxim = new Maxim(this);
  player = maxim.loadFile("sound2.wav");
  player1 = maxim.loadFile("sound3.wav");
  player.setLooping(false);
  player1.setLooping(false);
}

void draw(){
  if(startMenu){
    menu();
  } else {  
  int finish = 0;
  int[] posFix = new int[16];
  background(255);
  
  translate(width/2, height/2);
  rectMode(CENTER);
  
 if(button1){
      rotate1();
    }
    else if(button2){
      rotate2();
    }
     for(int i = 0; i < blocks; i++){
       block =(Block) blockCollection.get(i);
       posFix[block.pos] = 1;
     }
     //println(posFix);
    
      for(int i = 0; i < blocks; i++){
         block =(Block) blockCollection.get(i);
         if(block.blockType == 1){
           if(block.pos < 12 && posFix[block.pos + 4] == 0)block.down();
         }
         block.display();
         if(block.pos == 12 && block.blockType == 1)finish+=1;
         if(block.pos == 13 && block.blockType == 1)finish+=1;
         if(block.pos == 14 && block.blockType == 1)finish+=1;
         if(block.pos == 15 && block.blockType == 1)finish+=1;
         if(finish == 4){
           startGame();
           player1.play();
         }
         
      }
   
    }
       

     }


void mousePressed(){
  if(startMenu){
     startMenu = false;
     startGame();
  }else{
  if(mouseX < width/2){
    button1 = true;
  } else {
    button2 = true;
  }
  }
}

void rotate1(){
  if(ang1 > -PI/2){
    ang1 -= 0.1;
    rotate(ang1);
  } else { 
    button1 = false;
    ang1 = 0;
     for(int i=0; i < blocks; i++){
       block =(Block) blockCollection.get(i);
       block.rotateL();
       block.display();
     }
  }
}

void rotate2(){
  if(ang2 < PI/2){
    ang2 += 0.1;
    rotate(ang2);
  }else {  
     for(int i=0; i < blocks; i++){
       block =(Block) blockCollection.get(i);
       block.rotateR();
       block.display();
     }
    button2 = false;
    ang2 = 0;
  }
}

void startGame(){
  blockCollection = new ArrayList();
  int pos[] = new int[12];
  int k;//random namber
  int t = 1;
  blocks = 7;
  for(int i = 0; i < blocks; i++){
      if(i > 3) t = 0;
      k = (int)random(0,11);
    while(pos[k] == 1){
      k = (int)random(0,11);
    }
    pos[k] = 1;
    blockCollection.add(new Block(k,t));
  }
}
void menu(){
  fill(0);
  textSize(32);
  text("BlockBuster v 0.1",10,30);
  textSize(25);
  text("Collect all blocks in one line,", 10, 70);
  text("by turning the platform",10,100);
  fill(255,0,0);
  text("START",150, 150);
}
class Block {

  int[][] positions = {{-150, -150},{-50, -150},{50, -150},{150, -150},{-150, -50},{-50, -50},{50, -50},{150, -50},{-150, 50},{-50, 50},{50, 50},{150, 50},{-150, 150},{-50, 150},{50, 150},{150, 150}};
              
  int[] rotateLeft = {12,7,2,-3,9,4,-1,-6,6,1,-4,-9,3,-2,-7,-12};
  int[] rotateRight = {3,6,9,12,-2,1,4,7,-7,-4,-1,2,-12,-9,-6,-3};
  color c;
  float xpos;
  float ypos;
  int yspeed = 10;
  int w=100;
  int pos;
  int blockType;
  boolean flag;
  float current;
 


Block(int pos_, int block){
  if(block == 0)c = color(175);
  else c = color(255,0,0);
  xpos = positions[pos_][0];
  ypos = positions[pos_][1];
  current = ypos;
  pos = pos_;
  blockType = block; 
}



void display() {
  stroke(0);
  fill(c);
  rect(xpos,ypos,w,w);
}

void down(){
  ypos += yspeed;
  if (ypos == current + 100){
    current = ypos;
    pos += 4;
    player.play(); 
    
    
  }
  
  println(ypos);
  println(pos);
  }


void rotateL(){
  pos = pos + rotateLeft[pos];
  xpos = positions[pos][0];
  ypos = positions[pos][1];
  current = ypos;
  println(pos);
}

void rotateR(){
  pos = pos + rotateRight[pos];
  xpos = positions[pos][0];
  ypos = positions[pos][1];
  current = ypos;
  println(pos);
}

}



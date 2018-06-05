float X,Y;
int vec;
float velocity;
int score;
int fail;
int level;

int tani = 10;
float taniF[] = new float[tani];
float taniX[] = new float[tani];
float taniY[] = new float[tani];
float taniV[] = new float[tani];
float taniA[] = new float[tani];

int freq = 90;

PGraphics bg;
PGraphics box;

void setup(){
  size(640,480);
  init();
}

void init(){
  level = 1;
  X = 320;
  Y = 400;
  vec = 0;
  velocity = 0;
  score = 0;
  taniF = new float[tani];
  taniX = new float[tani];
  taniY = new float[tani];
  taniV = new float[tani];
  taniA = new float[tani];
  
  freq = 90;
  
  bg = createGraphics(640,480);
  box = createGraphics(60,60);
}

void draw(){
  X += vec * velocity;
  
  for(int i = 0; i < tani; ++i){
    if(taniF[i] == 1){
      taniY[i] += taniV[i];
      taniV[i] += taniA[i];
      
      if(taniX[i] > X - 30 && taniX[i] < X + 30 && Y + 30 < taniY[i]){
        taniF[i] = 3; // 単位取得
        score += 1;
  
        if(score % 8 == 0){
          level++;
          if(freq > 15)
          freq -= 15;
        }
      }
      
      if(taniY[i] > 460)
        taniF[i] = 2; // 落単
    }
  }
  
  if(frameCount % freq == 0){
    for(int i = 0; i < tani; ++i){
      if(taniF[i] == 0){
        taniF[i] = 1;
        taniX[i] = 120 + random(400);
        taniY[i] = -20;
        taniV[i] = 1 + random(level * 2) ;
        taniA[i] = 0.1 + random(0.025 + level * 0.06125);
        break;
      }
    }
  }
  
  if(keyPressed){
    if(key == 'z' || key == 'x'){
      int v = 0;
      if(key == 'z') v = -1;
      else if(key == 'x') v = 1;
      if(v * vec == -1)
        velocity = 0;
      vec = v;
    }
  }
  if(velocity <= 5.0)
    velocity += 0.06125;
  else
    velocity = 5.0;
  
  bg.beginDraw();
  box.beginDraw();
  for(int i = 0; i < tani; ++i){
    if(taniF[i] == 2){
      bg.fill(0);
      if(taniY[i] > 460)
        taniY[i] = 460;
      bg.text("単位", taniX[i] - 30, taniY[i]);
      taniF[i] = 0;
    }
    if(taniF[i] == 3){
      box.fill(0);
      box.text("単位", taniX[i] - X, taniY[i] - Y);
      taniF[i] = 0;
    }
  }
  bg.endDraw();
  box.endDraw();
  
  clear();
  background(255);
  image(bg,0,0);
  stroke(0);
  noFill();
  rect(X-30,Y,60,60);
  image(box,X-30,Y);
  for(int i = 0; i < tani; ++i){
    if(taniF[i] == 1){
      fill(0);
      text("単位", taniX[i] - 30, taniY[i]);
    }
  }
  text("Level:" + level + " Score:" + score, 4, 20);
}

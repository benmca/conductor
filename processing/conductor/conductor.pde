int myFrameRate=60; //<>// //<>// //<>// //<>//
int gutter = 20;
int totalBars = 80;
int countInBars = 2;
int myFrameCount = 0;
PFont theFont = null;
PFont theBigFont = null;

ArrayList<Animation> animations = new ArrayList<Animation>();
ArrayList<Change> changes = new ArrayList<Change>();
Change curChange = null;

void settings(){
  //fullScreen();
  size(720,480);  
}

void setup() {
  initChanges();
  background(0);
  frameRate(myFrameRate);
  smooth();
  theFont = loadFont("Helvetica-48.vlw");
  theBigFont = loadFont("Helvetica-200.vlw");
}

void initChanges(){
  changes.add(new Change(1, 60, 4, 4));
//  changes.add(new Change(3, 120, 3, 4));
  totalBars = 30;
  curChange = changes.get(0);
  myFrameCount = -(getCountInFrames());
}

void drawBoxes(){
  rect(0+gutter,0+gutter, width*.6-(gutter*2), height-(gutter*2));
  rect(width*.6,gutter, width*.4-(gutter), height-(gutter*2));
}

void drawText(){
  
  float boxWidth = width*.4-(gutter);
  //float boxCenter = boxWidth/2;
  textFont(theFont);
  textSize(height/24);
  textAlign(LEFT);
  text("Bar:", width*.6+(gutter), gutter, boxWidth, height*.1);  // Text wraps within text box
  textSize((height/4));
  //rect(width*.6, height*.1, boxWidth, height/3);
  textAlign(CENTER);
  textFont(theBigFont);
  text(Integer.toString(getCurBarNumber()), width*.6, height*.1, boxWidth, height/3);  // Text wraps within text box
  
  textFont(theFont);
  textSize(height/24);
  textAlign(LEFT);
  text("Beat:", width*.6+(gutter), height*.5);  // Text wraps within text box
  textSize(height/4);
  textAlign(CENTER);
  //rect(width*.6, height*.5, boxWidth, height/3 );  // Text wraps within text box
  textFont(theBigFont);
  text(Integer.toString(getCurBeat()), width*.6, height*.5, boxWidth, height/3 );  // Text wraps within text box
  
  textFont(theFont);
  textSize(height/24);
  textAlign(LEFT);
  text("Tempo: " + Float.toString(curChange.tempo), width*.6+(gutter), height*.9);  // Text wraps within text box
  text("Count In Bars: " + Integer.toString(countInBars), width*.6+(gutter), height*.95);  // Text wraps within text box
  //text("Count In Bars: " + Integer.toString(countInBars), width*.6+(gutter) + 100, height*.95);  // Text wraps within text box
}


int getTotalFramesPerCircle(Change theChange){
  return (int)(theChange.getDur()*myFrameRate*theChange.num);
}

int getTotalFramesPerCircle(){
  return (int)(curChange.getDur()*myFrameRate*curChange.num);
}

int getTotalFramesPerSegment(Change theChange){
  return (int)(theChange.getDur()*myFrameRate);
}

int getTotalFramesPerSegment(){
  return (int)(curChange.getDur()*myFrameRate);
}

int getCountInFrames(){
  Change firstChange = changes.get(0);
  return (int)(getTotalFramesPerCircle(firstChange) * countInBars);
}

int getCurBarNumber(){
  return (myFrameCount < 1) ? 
    -(1-(int)(myFrameCount/getTotalFramesPerCircle())) :
    1+(int)(myFrameCount/getTotalFramesPerCircle());  
}

int getCurBeat(){
  return (myFrameCount < 1) ? 
    (4 + (myFrameCount % getTotalFramesPerCircle()/getTotalFramesPerSegment())) : 
    1+(myFrameCount % getTotalFramesPerCircle()/getTotalFramesPerSegment());
}

void draw() {
  background(0);
  stroke(0xffffffff);
  strokeWeight(1);
  noFill();

  drawBoxes();
  drawText();

  int i = (360*(myFrameCount % getTotalFramesPerCircle())) / getTotalFramesPerCircle();
  float radius = (int)(width*.2);
  int x = int(radius * (sin(PI/180.* i))  );
  int y = int(radius * (1.-cos(PI/180.* i))  );
  int centerx = (int)(width*.3);
  int centery = (int)(height*.5);
  
  ellipse(centerx, centery, radius*2-20, radius*2-20);
  ellipse(centerx, centery, radius*2,radius*2);
  line(centerx, centery,x+centerx, y+(centery-radius));
  point(x+centerx, y+(centery-radius));

  if(myFrameCount % getTotalFramesPerSegment() == 1){
    animations.add(new BeatAnimation(x+centerx, (int)(y+(centery-radius)),myFrameCount, 20)); 
  }
  if(myFrameCount % getTotalFramesPerCircle() == 1){
    animations.add(new BeatAnimation(x+centerx, (int)(y+(centery-radius)),myFrameCount, 20)); 
    animations.add(new DownbeatAnimation(centerx, centery, radius, myFrameCount, (int)(getTotalFramesPerCircle()*.25))); 
  }
  updateAnimations();
  myFrameCount++;
}

void resetSketch(){
      for(int i=animations.size()-1;i>=0;i--){
      //Animation item = animations.get(i);
      animations.remove(i);
    }
    initChanges();
    background(0);
}

void keyPressed() {
  if (key == ' ') {
    resetSketch();
  } 
  if (keyCode == 37){
    countInBars--;
    resetSketch();
  }
  if (keyCode == 39){
    countInBars++;
    resetSketch();
  }
  
  if (keyCode == 38){
    //countInBars--;
    //resetSketch();
  }
  if (keyCode == 40){
    //countInBars++;
    //resetSketch();
  }
  
  //System.out.println(Integer.toString(keyCode));
}


void updateAnimations(){
  for(int i=animations.size()-1;i>=0;i--){
    Animation item = animations.get(i);
    if(item.finished()){
      animations.remove(i);
    } else {
      item.updateMe();
    }
  }
}
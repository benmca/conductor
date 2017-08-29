public class Change {
  int barNumber = 1;
  int tempo = 120;
  int num = 4;
  int denom = 4;
  public Change(int a, int b, int c, int d){
    barNumber = a;
    tempo = b;
    num = c;
    denom = d;
  }
}

public class Animation{
  int anchorX = 0;
  int anchorY = 0;
  int startFrame = 0;
  int durFrames = 0;
  public Animation(int x, int y, int start, int dur){
    anchorX = x;
    anchorY = y;
    startFrame = start;
    durFrames = dur;
  }
  
  public boolean finished(){
    return (frameCount > (startFrame+durFrames));
  }
  
  public void updateMe(){
    if(finished()){ //<>// //<>//
      return;
    }
    int relativeFrameCount = frameCount - startFrame; //<>//
//    fill(#FF0000, (1.0-((float)relativeFrameCount/(float)durFrames)) * 255.0);
    fill(#FFFFFF, (1.0-((float)relativeFrameCount/(float)durFrames)) * 255.0);
    noStroke();
    ellipse(anchorX, anchorY, width*.3,width*.3);
    stroke(#FFFFFF);
    fill(#FFFFFF);
  }
}  

int myFrameRate=60;
int barNumber = 1;
int gutter = 20;
int totalBars = 80;
ArrayList<Animation> animations = new ArrayList<Animation>();
ArrayList<Change> changes = new ArrayList<Change>();
Change curChange = null;
void settings(){
  fullScreen();
//  size(720,480);  
}

void setup() {
  loadChanges();
  background(0);
  frameRate(myFrameRate);
  smooth();
}

void loadChanges(){
  changes.add(new Change(1, 40, 4, 4));
//  changes.add(new Change(3, 120, 3, 4));
  totalBars = 30;
  curChange = changes.get(0);
  changes.remove(0);
}

void drawBoxes(){
  rect(0+gutter,0+gutter, width*.6-(gutter*2), height-(gutter*2));
  rect(width*.6,gutter, width*.4-(gutter), height-(gutter*2));
}

void drawText(float tempo, int barNumber, int beat){
  float boxWidth = width*.4-(gutter);
  float boxCenter = boxWidth/2;
  textSize(height/24);
  textAlign(LEFT);
  text("Bar:", width*.6+(gutter), gutter, boxWidth, height*.1);  // Text wraps within text box
  textSize((height/4));
  //rect(width*.6, height*.1, boxWidth, height/3);
  textAlign(CENTER);
  text(Integer.toString(barNumber), width*.6, height*.1, boxWidth, height/3);  // Text wraps within text box
  
  textSize(height/24);
  textAlign(LEFT);
  text("Beat:", width*.6+(gutter), height*.5);  // Text wraps within text box
  textSize(height/4);
  textAlign(CENTER);
  //rect(width*.6, height*.5, boxWidth, height/3 );  // Text wraps within text box
  text(Integer.toString(beat), width*.6, height*.5, boxWidth, height/3 );  // Text wraps within text box
  
  textSize(height/24);
  textAlign(LEFT);
  text("Tempo: " + Float.toString(tempo), width*.6+(gutter), height*.9);  // Text wraps within text box
}

void draw() {
  stroke(0xffffffff);
  strokeWeight(1);
  noFill();

  float tempo = 60.0;
  int num = 4;
  int denom = 4;
  float dur = 60/tempo;
  int totalFramesPerCircle = (int)(dur*myFrameRate*num);
  int totalFramesPerSegment = (int)(dur*myFrameRate);
  //int barNumber = 1+(int)(frameCount/totalFramesPerCircle);
  
  
  int beat = 1+(frameCount % totalFramesPerCircle/totalFramesPerSegment);
  // todo - need to determine if this is downbeat or not, and update from changes that way...
  if((1+(int)(frameCount/totalFramesPerCircle)) > barNumber){
    barNumber++;
  }
  
  background(0);
  drawBoxes();
  drawText((int)tempo, barNumber, beat);

  int i = (360*(frameCount%totalFramesPerCircle)) / totalFramesPerCircle;
  float radius = (int)(width*.2);
  int x = int(radius * (sin(PI/180.* i))  );
  int y = int(radius * (1.-cos(PI/180.* i))  );
  int centerx = (int)(width*.3);
  int centery = (int)(height*.5);
  
  ellipse(centerx, centery, radius*2-20, radius*2-20);
  ellipse(centerx, centery, radius*2,radius*2);
  line(centerx, centery,x+centerx, y+(centery-radius));
  point(x+centerx, y+(centery-radius));
  
  //drawArcs
  
  //fill(255);
  //arc(centerx, centery, radius*2-20, radius*2-20, radians(270), radians(i), PIE);
  //noFill();
  
  if(frameCount % totalFramesPerSegment == 1){
    animations.add(new Animation(x+centerx, (int)(y+(centery-radius)),frameCount, 20)); 
  }
  updateBeatAnimation();
}


void updateBeatAnimation(){
  for(int i=animations.size()-1;i>=0;i--){
    Animation item = animations.get(i);
    if(item.finished()){
      animations.remove(i);
    } else {
      item.updateMe();
    }
  }
}
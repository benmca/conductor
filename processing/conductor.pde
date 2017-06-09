int myFrameRate=60;
int barNumber = 1;

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
    fill(#FF0000, (1.0-((float)relativeFrameCount/(float)durFrames)) * 255.0);
    noStroke();
    ellipse(anchorX, anchorY, width*.1,width*.1);
    stroke(#FFFFFF);
    fill(#FFFFFF);
  }
}  

ArrayList<Animation> animations = new ArrayList<Animation>();
void settings(){
  fullScreen();
}

void setup() {
  background(0);
  frameRate(myFrameRate);
  smooth();
  textSize(height/12);
}

void drawText(float tempo, int barNumber, int beat){
  text("Tempo: " + Float.toString(tempo), width*.6, height*.5);  // Text wraps within text box
  text("Bar: " + Integer.toString(barNumber), width*.6, height*.7);  // Text wraps within text box
  text("Beat: " + Integer.toString(beat), width*.6, height*.9);  // Text wraps within text box
}

void draw() {
  stroke(0xffffffff);
  strokeWeight(1);
  noFill();

  float tempo = 120.0;
  int num = 6;
  int denom = 4;
  float dur = 60/tempo;
  int totalFramesPerCircle = (int)(dur*myFrameRate*num);
  int totalFramesPerSegment = (int)(dur*myFrameRate);
  int barNumber = 1+(int)(frameCount/totalFramesPerCircle);
  int beat = 1+(frameCount % totalFramesPerCircle/totalFramesPerSegment);
  
  background(0);
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
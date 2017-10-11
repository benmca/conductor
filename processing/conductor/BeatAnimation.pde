
public class BeatAnimation implements Animation{
  int anchorX = 0;
  int anchorY = 0;
  int startFrame = 0;
  int durFrames = 0;
  public BeatAnimation(int x, int y, int start, int dur){
    anchorX = x;
    anchorY = y;
    startFrame = start;
    durFrames = dur;
  }
  
  public boolean finished(){
    return (myFrameCount > (startFrame+durFrames));
  }
  
  public void updateMe(){
    if(finished()){
      return;
    }
    int relativeFrameCount = myFrameCount - startFrame;
//    fill(#FF0000, (1.0-((float)relativeFrameCount/(float)durFrames)) * 255.0);
    fill(#FFFFFF, (1.0-((float)relativeFrameCount/(float)durFrames)) * 255.0);
    noStroke();
    ellipse(anchorX, anchorY, width*.3,width*.3);
    stroke(#FFFFFF);
    fill(#FFFFFF);
  }
}  
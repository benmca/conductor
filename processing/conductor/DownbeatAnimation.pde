public class DownbeatAnimation extends BeatAnimation {

  float radius = 0.0;

  public DownbeatAnimation(int x, int y, float r, int start, int dur) {
    super(x, y, start, dur);
    radius = r;
  }

  public void updateMe() {
    if (finished()) {
      return;
    }
    int relativeFrameCount = myFrameCount - startFrame;
    fill(#FF0000, (1.0-((float)relativeFrameCount/(float)durFrames)) * 255.0);
    noStroke();
    //ellipse(anchorX, anchorY, width*.5, width*.5);
    rect(0,0,width,height);
    stroke(#FFFFFF);
    fill(#FFFFFF);
  }
}
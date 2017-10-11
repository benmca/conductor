public class Change {
  int barNumber = 1;
  int tempo = 120;
  int num = 4;
  int denom = 4;
  
  float getDur(){
    float dur = 60.0/tempo;
    return dur;
  }
  public Change(int a, int b, int c, int d){
    barNumber = a;
    tempo = b;
    num = c;
    denom = d;
  }
}
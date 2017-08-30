public class Change {
  int barNumber = 1;
  int tempo = 120;
  int num = 4;
  int denom = 4;
  
  float getDur(){
    return 60/tempo;
  }
  public Change(int a, int b, int c, int d){
    barNumber = a;
    tempo = b;
    num = c;
    denom = d;
  }
}
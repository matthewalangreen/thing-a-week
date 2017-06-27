// PolarGraph Class Definition
// Version 1.2
// Matthew Green
// June 7, 2017
// ***************************
class PolarGraph
{
  // data  
  float xPos,yPos,period,theta,alpha,increment,dotController,r,a,size;
  color curColor,temp;
  ArrayList<PVector> valueVectors;
  
  // ** REMEMBER **
  // r = 140*sin(-a*theta);
  // xPos = r * cos(theta);
  // yPos = r * sin(theta);
  
  // constructor 
  PolarGraph() {
    a = 0.7;  // 0.6 is default
    period = PI/2;
    theta = 0;
    alpha = theta;
    dotController = 50;
    increment = period/dotController;
    size = 220;
    valueVectors = new ArrayList<PVector>();
    //r = 300 * sin(-a*theta);
  }
  
  // methods
  void calculateValuePairs(float val) {
    valueVectors.clear();
    for(float i = 0; i<30*PI; i+=increment) {
      float tx = size*sin(-val*i)*cos(i) + width/2;
      float ty = size*sin(-val*i)*sin(i) + height/2;
      valueVectors.add(new PVector(tx,ty));
    }
  }
  
  float[] getValuePair(int index) {
    if(index < valueVectors.size()) {
      return new float[] {valueVectors.get(index).x,valueVectors.get(index).y};     
    } else {
      return new float[] {-1000,1000};
    }
  }
  
  int valuePairsSize() {
   return valueVectors.size();
  }
  
  // ***********************************************
  
  // deprecated
  //void update() {        
  // r = size * sin(-a*theta);
  // theta += increment; 
  // xPos = r * cos(theta) + width/2;
  // yPos = r * sin(theta) + height/2;
  //}
  
} // End of polar class
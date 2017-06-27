// *************** ColorMixer Class ************************* //
// ColorMixer Class Definition
// Version 1.1
// Matthew Green
// May 24, 2017
// ***************************
class ColorMixer
{
  // data  
  float x,limit,e;
  color c1,c2,mix,temp;
  int i,indexDelta,arrLength;
  color[] palette;
  
  // constructor 
  ColorMixer(color[] _colors) { 
   palette = _colors;
   x = 0;
   limit = (5*PI)/12;
   i = 1;
   indexDelta = 1;
   arrLength = palette.length;
   e = 2.71828;
   c1 = palette[0]; // eliminates black spot from v1.0
   c2 = palette[1]; // -------------------------------
  }
  
  // methods

  color randomColor() {
    int c,d;
    c = (int)random(0,arrLength-1);
    d = c+1;
   return lerpColor(palette[c],palette[d],random(0,1));
  }
  
  color mixColors(float delta) {
    x += delta;
    if(x > limit) {
     x = 0;
     if(i == arrLength - 2) {
       indexDelta = -1;
     }
     
     if(i == 0) {
       indexDelta = 1;
     }
     
     if(indexDelta == 1) {
       c1 = palette[i];
       c2 = palette[i+1];
     }
     
     if(indexDelta == -1) {
       c1 = palette[i+1];
       c2 = palette[i];
     }
     i += indexDelta;
    }
    return lerpColor(c1,c2,h(x));
  }
 
  // helper methods -- used in to mix colors at different rates
  // see this for more info: https://www.desmos.com/calculator/pv0mckn3rl
  float f(float input) {
  return (limit*limit*input*input);
  }

  float g(float input) {  
    return ((float)Math.pow(e,(input-1))-0.367);
  }
  
  float h(float input) {
     return sin(1.2*input);
  }
  
  float j(float input) {
     return 0.7639*input;
  }
  
  float k(float input) {
     return 0.139*log(1000*input);
  }
  
}
 

// *************** End of ColorMixer Class ************************* //
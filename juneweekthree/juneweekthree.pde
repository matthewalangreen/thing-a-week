import java.util.Iterator; // for keeping track of dots as they die

// Dot Instances
ArrayList<Dot> dots = new ArrayList<Dot>();
Dot cDot;
PVector location;

// Color Stuff
color[] pastels = {color(194, 86, 119), color(199, 122, 159), color(178, 116, 158), 
  color(157, 111, 156), color(139, 108, 155), color(125, 110, 160), color(117, 114, 163), 
  color(81, 90, 157), color(118, 145, 199), color(101, 174, 208), color(92, 153, 169), 
  color(99, 172, 171), color(255,131,0), /*orange */ color(100, 170, 154), 
  color(105, 166, 142), color(106, 166, 130) };
  
ColorMixer myMixer = new ColorMixer(pastels);
float mix = 0.05; // 0.3 is default

// Polar graph stuff...
float[] aVals = {0.4,0.35,0.2,0.5,4,0.6,0.75,1.4,2,3};  
PolarGraph myGraph = new PolarGraph();
int numPairs = 0; // to keep track of size of coordinates array in myGraph
float tempX,tempY; // same as above
float currentAVal;

boolean moving = true;
int aValsIndex = 0;  // used to keep track of where we are in the aVals[] array

boolean makeNew = false;
boolean looping = true;
void setup()
{
  ellipseMode(CENTER);
  size(600, 600);
  noStroke();
  frameRate(24); // 100 is default
  currentAVal = aVals[1];
  myGraph.calculateValuePairs(currentAVal); // calculate locations on first curve
  
  location = new PVector(random(width),random(height));
}

void keyPressed()
{
  if(key =='l') {
    
    if(looping) {
      noLoop();
    } else {
      loop();
    }
    looping = !looping;
  }
  if(key =='c') {
    dots.clear();
    makeDot();
  }
  if(key =='a') {
   makeDots(1); 
  }
  if(key =='b') {
    makeDots(100);
  }
  if(key =='m') {
   moving = !moving; 
  }
  if(key == 'v') {
    int t = (int)random(0,aVals.length-1);
    currentAVal = aVals[t];
    myGraph.calculateValuePairs(currentAVal);
  }
} 

void draw()
{
  println("Current Curve a Value: "+currentAVal);
  if(makeNew) {
   makeDots(8);
   makeNew = false;
  }
  background(0);
  
  numPairs = myGraph.valuePairsSize(); // keep track of how many coordinate pairs their are for error checking
  
  // loop through dots and draw them based on if they should be moving or not...
  for (int i = 0; i< dots.size(); i++ ) {
    cDot = dots.get(i); // keep track of the current dot
    if(moving) { // if mouse is clicked ******************** CHANGE THIS TO REFLECT TWO BUTTONS PRESSED **********************************
      if(numPairs > i) { //error checking
        float[] t =  myGraph.getValuePair(i);
        tempX = t[0];
        tempY = t[1];
        
        // make new target for each dot to arrive at
        PVector preAllocPolar = new PVector(tempX,tempY);
        cDot.arrive(preAllocPolar);
      }

    } else { // if not moving, send all dots back to their original positions...
     PVector home = new PVector(cDot.x(),cDot.y());
     cDot.arrive(home);
    }
    // draw update their positions and draw them to the screen
    cDot.update();
    cDot.display();
    // myGraph.update();
  }  // end of dots loop
 
  // Check to see if dots are alive.  Remove the dead ones.
  Iterator<Dot> it = dots.iterator();
  while (it.hasNext()) {
    Dot p = it.next();
    p.update();
    if (p.isDead()) {
      it.remove();
      makeNew = true;
    }
  }
}

// helper functions
void makeDot() {
   dots.add(new Dot(random(width), random(height), myMixer.mixColors(mix)));
}

void makeDots(int num) {
  for(int i = 0; i<num; i++) {
    makeDot();
  }
}


 
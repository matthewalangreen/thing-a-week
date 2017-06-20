class Dot {
  
  // Data
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector newLocation;
  float firstX, firstY, radius, lifespan,maxForce,maxSpeed;
  color dotColor;
  float radiusChange;
  float deathRate;
  int counter;
  boolean growing;

  // Constructor
  Dot(float _firstX, float _firstY, color _dotColor) {
    
    // ********************************** CHANGE THESE AS NEEDED *************************
    maxSpeed = 16;  // 7 is default
    maxForce = 1.2; // 0.4 is default
    deathRate = 1.5; // 0.8 is default
    radiusChange = 0.1; // 0.04 is default
    lifespan = random(150,400); //100,255 is default
    // ***********************************************************************************
    
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(_firstX, _firstY);
    newLocation = location;
    radius = random(10,20); 
    dotColor = _dotColor;
    firstX = _firstX;
    firstY = _firstY;
    growing = true;
    counter = 0;
  }

  // Methods
 
  
  float getMaxSpeed() {
   return maxSpeed; 
  }
  
  float getMaxForce() {
   return maxForce; 
  }
  
  void increaseMaxSpeed() {
    maxSpeed += 0.25;
  }
  
  void decreaseMaxSpeed() {
    maxSpeed -= 0.25;
  }
  
  void increaseMaxForce() {
    maxForce += 0.25;
  }
  
  void decreaseMaxForce() {
    maxForce -= 0.25;
  }
  
  PVector getNewLocation() {
    return newLocation;
  }
  
  void setNewLocation(float x, float y) {
   newLocation = new PVector(x,y); 
  }
  
  float x() {
   return firstX; 
  }
  
  float y() {
   return firstY; 
  }
  
   void pulse() {
    counter++;
    if(counter > 30) {
      counter = 0;
      growing = !growing;
      radiusChange = radiusChange*(-1);
    }
    radius += radiusChange;
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    //lifespan -= .08; // change this to affect how long they live overall
    lifespan -= deathRate;
   // pulse();
  }
  
   void display() {
    //float disp = map(lifespan, 1000, 3000, 0, 255);
    //stroke(1, lifespan);
    fill(dotColor, lifespan);
    ellipse(location.x, location.y, radius, radius);
    //rect(location.x, location.y, radius, radius);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void arrive(PVector target) {
    PVector desired = PVector.sub(target, location);

    // The distance is the magnitude of
    // the vector pointing from
    // location to target.
    float d = desired.mag();
    desired.normalize();
    // If we are closer than 100 pixels...
    if (d < 100) {
      //[full] ...set the magnitude
      // according to how close we are.
      float m = map(d, 0, 100, 0, maxSpeed);
      desired.mult(m);
      //[end]
    } else {
      // Otherwise, proceed at maximum speed.
      desired.mult(maxSpeed);
    }

    // The usual steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
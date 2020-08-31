class Mover {
  PVector location;
  PVector speed;
  PVector acceleration;
  float mass;
  float maxspeed = 20;
  float edgeThreshold = 20;

  Mover(float x, float y, float m) {
    location = new PVector(x,y);
    speed = PVector.random2D().mult(3);
    acceleration = new PVector();
    mass = m;
  }

  void applyForce(PVector force) {
    PVector f = force.copy().div(mass);
    acceleration.add(f.div(mass));
  }
  
  void checkEdges(){
      float lx = location.x - edgeThreshold;
      float rx = location.x - (width - edgeThreshold);
      if (lx < edgeThreshold){
         applyForce(new PVector((lx*lx),0)); 
      }else
      if (rx > edgeThreshold){
         applyForce(new PVector((rx*rx) * (-1),0));
      }
  }
  
  void move(){
    if (location.y < mass){
      speed.y *= -1;
      location.y = mass;
    }
    speed.add(acceleration);
    location.add(speed.limit(maxspeed));
    acceleration.mult(0);
  }
  
  boolean isInside(Liquid l){
    return ((location.x>l.x) && (location.x<l.x+l.w) && (location.y>l.y) && (location.y<l.y+l.h)); 
  }
  
  void drag(Liquid l){
    float sp = speed.mag();
    float dragMagnitude = l.c * sp * sp;
    PVector drag = speed.copy().mult(-1).normalize().mult(dragMagnitude);
    applyForce(drag);
  }

  void draw() {
    fill(255);
    stroke(0);
    ellipse(location.x, height - location.y, mass, mass);
  }
}
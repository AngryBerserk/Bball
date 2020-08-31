PVector gravity = new PVector(0, -16);
Mover[] movers;
Liquid liquid;

void setup(){
 size(800,600);
 movers = new Mover[10];
 for (int i=0; i < movers.length; i++){
   movers[i] = new Mover(random(width), random(height /2, height), random(10,20));
 }
 liquid = new Liquid(0,0, width, height/2, 10);
}

void draw(){
 background(255, 0.5);
 liquid.display();
 for (Mover mover : movers){
   PVector g = gravity.copy();
   g.y *= mover.mass;
   mover.applyForce(g);
   if (mover.isInside(liquid))
     mover.drag(liquid);
   mover.checkEdges();
   mover.move();
   mover.draw();
 }
}
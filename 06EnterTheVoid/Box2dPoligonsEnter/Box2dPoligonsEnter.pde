import shiffman.box2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Box> boxes;


float time=0;

  
 Boundary d;
 int wait=1001;
 
 PImage mask;
 int frameNum;
 String cont;

 
void setup() {
  
  size(1920,1080,P2D);
  boxes = new ArrayList<Box>();
  
  box2d = new  Box2DProcessing(this);
    
  box2d.createWorld();
  
  box2d.setGravity(0, 0);
   
   strokeWeight(1);
   
   mask = loadImage("mask.png");
   mask.resize(width, height);
   cont="0";
   
  // d= new Boundary(width/2,height/2,100,100);
}
 
void draw() {
  
  frameNum++; 
  cont = str(frameNum);
  
  fig();
  
  //saveHiRes(2);
  saveFrame("#####_polygonWhite");
  
  
}

void fig(){

  stroke(255);
   
  background(0);
 
 float cl=random(100);
   
  box2d.step();
  
  if (wait>100 ) {
    Box p = new Box();
    boxes.add(p);
    wait=0;
  }
  wait++;
 
//Display all the Box objects.
  for (Box b: boxes) {
    
    b.display(time);
  }
  
   time+=0.5;
   
   for (int i = boxes.size()-1; i >= 0; i--) {
    Box p = boxes.get(i);
    if (p.done()) {
      boxes.remove(i);
    }
  }
  
  image(mask, 0, 0);

}

void mousePressed(){

  saveFrame("###_polygon");

}

 


void saveHiRes(int scaleFactor) {
  
  PGraphics hires = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);
  beginRecord(hires);
  hires.scale(scaleFactor);
  fig();
  endRecord();
  hires.save("hires"+cont+".png");
}



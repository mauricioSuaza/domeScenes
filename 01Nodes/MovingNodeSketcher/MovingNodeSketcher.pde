/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/93017*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */

import toxi.geom.*; 
import toxi.processing.*;

ToxiclibsSupport gfx;

ArrayList<Vec2D> segments;
ArrayList<MovingNode> nodes;
float maxDistance = 65;
float dx = 30;
float dy = 30;
float maxNeighbors = 10;
PImage mask;
int frameNum;
String cont;

PImage [] images = new PImage [3];
PImage photo;
float r,g,b;
int xpos, ypos;

Boolean drawMode = true;

void setup()
{
  size(400,400,P2D);
  //size(1920,1080,P2D);
  //background(220);
  nodes = new ArrayList<MovingNode>();
  segments = new ArrayList<Vec2D>();
   mask = loadImage("mask.png");
   mask.resize(width, height);
   cont="0";
   
  images[0]= loadImage("img1.jpg");
  images[0].resize(width, height);
  
  images[1]= loadImage("img2.jpg");
  images[1].resize(width, height);
  images[2]= loadImage("img3.jpg");
  images[2].resize(width, height);
  
  gfx=new ToxiclibsSupport(this);
  
     
  strokeWeight(2);
  PImage nodeCol= images[0];
}

void draw()
{
  frameNum++; 
  cont = str(frameNum);
  //println(nodes.size());
  
  background(220);
  addNewNode(random(0,width),random(0,height),random(-dx,dx),random(-dx,dx),images[0]);
  
  if(drawMode)
  {
    if(mousePressed){
      addNewNode(mouseX,mouseY,random(-dx,dx),random(-dx,dx),images[0]);
    }
  } else
  {
    addNewNode(random(width),random(height),0,0,images[0]);
  }
  
  for(int i=0; i<nodes.size(); i++)
  {
    MovingNode currentNode = nodes.get(i);
    currentNode.setNumNeighbors( countNumNeighbors(currentNode,maxDistance) );
  }
  
  for(int i=0; i<nodes.size(); i++)
  {
    MovingNode currentNode = nodes.get(i);
    if(currentNode.x > width || currentNode.x < 0 || currentNode.y > height || currentNode.y < 0)
    {
      nodes.remove(currentNode);
    }
  }
  
  for(int i = 0; i < nodes.size(); i++){
    MovingNode currentNode = nodes.get(i);
    for(int j=0; j<currentNode.neighbors.size(); j++)
    {
      MovingNode neighborNode = currentNode.neighbors.get(j);
      float lineColor = currentNode.calculateLineColor(neighborNode,maxDistance);
      //stroke(lineColor, lineColor, lineColor);
      //line(currentNode.x,currentNode.y,neighborNode.x,neighborNode.y);
  
      Line2D l=new Line2D(new Vec2D(currentNode.x,currentNode.y), new Vec2D(neighborNode.x,neighborNode.y));
     
    int t = 0;
    Vec2D last = new Vec2D() ;
    
         nodeCol.loadPixels();
      
      for(Vec2D p : l.splitIntoSegments(null,8,true)) {
        
        if(t>1){
        
        beginShape(POINTS);
        
        int loc=int(p.x)+int(p.y)*width;
        loc=constrain(loc,0,width*height-1);
        r = red(nodeCol.pixels[loc]);
        g = green(nodeCol.pixels[loc]);
        b = blue(nodeCol.pixels[loc]);
        c=color(r,g,b);
         
        stroke(c);
         
        vertex(last.x,last.y);
        
        vertex(p.x,p.y);
       
         
        endShape();
        
        }
         last = new Vec2D(p.x,p.y);  
        
         t++;      
     }
       
 
      //segments = l.splitIntoSegments(null,10,true);
      
     // gfx.line(l);
    }
    currentNode.display();
  }
  
  image(mask, 0, 0);
  
  //saveHiRes(2);
  //saveFrame("###_nodes");
  
}

void addNewNode(float xPos, float yPos, float dx, float dy, PImage nodeColor)
{
  //println("add new node");
  //generates a random location within a 50x50px box around the mouse
  //float xPos = mouseX + random(-50,50);
  //float yPos = mouseY + random(-50,50);
  //adds a node at this location
  MovingNode node = new MovingNode(xPos+dx,yPos+dy,nodeColor);
  
  node.setNumNeighbors( countNumNeighbors(node,maxDistance) );
  
  //println("newly added node has " + node.numNeighbors + " neighbors");
  //println("and neighbors.size() = " + node.neighbors.size());
  
  
  if(node.numNeighbors < maxNeighbors){
    nodes.add(node);
    for(int i=0; i<nodes.size(); i++)
    {
      MovingNode currentNode = nodes.get(i);
      currentNode.setNumNeighbors( countNumNeighbors(currentNode,maxDistance) );
    }
  }
  
  
}

int countNumNeighbors(MovingNode nodeA, float maxNeighborDistance)
{
  int numNeighbors = 0;
  nodeA.clearNeighbors();
  
  for(int i = 0; i < nodes.size(); i++)
  {
    MovingNode nodeB = nodes.get(i);
    float distance = sqrt((nodeA.x-nodeB.x)*(nodeA.x-nodeB.x) + (nodeA.y-nodeB.y)*(nodeA.y-nodeB.y));
    if(distance < maxNeighborDistance)
    {
      numNeighbors++;
      nodeA.addNeighbor(nodeB);
    }
  }
  return numNeighbors;
}

void keyPressed()
{
  drawMode = !drawMode;
  nodes = new ArrayList<MovingNode>();
}
class MovingNode
{
  float x;
  float y;
  int numNeighbors;
  ArrayList<MovingNode> neighbors;
  float lineColor;
  float nodeWidth = 3;
  float nodeHeight = 3;
  float fillColor = 50;
  float lineColorRange = 180;
  
  float xVel=0;
  float yVel=0;
  float xAccel=0;
  float yAccel=0;
  
  float accelValue = 0.5;
  
  PImage nodeCol;
  color c;

  MovingNode(float xPos, float yPos, PImage nodeColor)
  {
    x = xPos;
    y = yPos;
    numNeighbors = 0;
    neighbors = new ArrayList<MovingNode>();
    nodeCol = nodeColor;
  }
  
  void display()
  {
    move();
     
    nodeCol.loadPixels();
  
    int loc=int(x)+int(y)*width;
    loc=constrain(loc,0,width*height-1);
    r = red(nodeCol.pixels[loc]);
    g = green(nodeCol.pixels[loc]);
    b = blue(nodeCol.pixels[loc]);
    c=color(r,g,b);
    
    
    noStroke();
    fill(c);
    ellipse(x,y,nodeWidth,nodeHeight);
    //ellipse(x,y,10,10);
  }
  
  void move()
  {
    xAccel = random(-accelValue,accelValue);
    yAccel = random(-accelValue,accelValue);
    
    xVel += xAccel;
    yVel += yAccel;
    
    x += xVel;
    y += yVel;
  }
  
  void addNeighbor(MovingNode node)
  {
    neighbors.add(node);
  }
  
  void setNumNeighbors(int num)
  {
    numNeighbors = num;
  }
  
  void clearNeighbors()
  {
    neighbors = new ArrayList<MovingNode>();
  }
  
  float calculateLineColor(MovingNode neighborNode, float maxDistance)
  {
    float distance = sqrt((x-neighborNode.x)*(x-neighborNode.x) + (y-neighborNode.y)*(y-neighborNode.y));
    lineColor = (distance/maxDistance)*lineColorRange;
    return lineColor;
  }
    
}
class Node
{
  float x;
  float y;
  int numNeighbors;
  ArrayList<Node> neighbors;
  float lineColor;
  float nodeWidth = 3;
  float nodeHeight = 3;
  float fillColor = 50;
  float lineColorRange = 160;

  Node(float xPos, float yPos)
  {
    x = xPos;
    y = yPos;
    numNeighbors = 0;
    neighbors = new ArrayList<Node>();
  }
  
  void display()
  {
    noStroke();
    fill(fillColor);
    ellipse(x,y,nodeWidth,nodeHeight);
  }
  
  void addNeighbor(Node node)
  {
    neighbors.add(node);
  }
  
  void setNumNeighbors(int num)
  {
    numNeighbors = num;
  }
  
  void clearNeighbors()
  {
    neighbors = new ArrayList<Node>();
  }
  
  float calculateLineColor(Node neighborNode, float maxDistance)
  {
    float distance = sqrt((x-neighborNode.x)*(x-neighborNode.x) + (y-neighborNode.y)*(y-neighborNode.y));
    lineColor = (distance/maxDistance)*lineColorRange;
    return lineColor;
  }
    
}

void saveHiRes(int scaleFactor) {
  
  PGraphics hires = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);
  beginRecord(hires);
  hires.scale(scaleFactor);
  draw();
  endRecord();
  hires.save("hi"+cont+".png");
}



// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Wolfram Cellular Automata

// Simple demonstration of a Wolfram 1-dimensional cellular automata
// When the system reaches bottom of the window, it restarts with a new ruleset
// Mouse click restarts as well

CA ca;   // An object to describe a Wolfram elementary Cellular Automata

int delay = 0;


PImage [] images = new PImage [3];
PImage nodeCol;
float r,g,b;
int xpos, ypos;
color c;

void setup() {
   size(1920,1080,P2D);
  background(255);
  int[] ruleset = {
   0, 1, 0, 1, 1, 0, 1, 0
  };    // An initial rule system
  ca = new CA(ruleset);                 // Initialize CA
  frameRate(30);
  
  images[0]= loadImage("img1.jpg");
  images[0].resize(width, height);
  
  images[1]= loadImage("img2.jpg");
  images[1].resize(width, height);
  images[2]= loadImage("img12.jpg");
  images[2].resize(width, height);
  
  nodeCol= images[2];
}

void draw() {
  ca.display(nodeCol);          // Draw the CA
  ca.generate();

  if (ca.finished()) {   // If we're done, clear the screen, pick a new ruleset and restart
   
      background(255);
      ca.randomize();
      ca.restart();
      delay = 0;
    
  }
   saveFrame("######_ca");
}

void mousePressed() {
  background(255);
  ca.randomize();
    if (ca.finished()){
    //background(0);
    ca.randomize();
    ca.restart();
  }
}


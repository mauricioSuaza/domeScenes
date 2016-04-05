int scaler = 200;

Creature c0;

void setup(){
  
  size(1920,1080,P2D);
  
  stroke(255,122);
  
   c0 = new Creature (width/2, height/2);

}

void draw(){
  
   background(0);
 
  noFill();
  c0.display();

}

class Creature{
  
  int x;
  int y;
  int m= 2;
  int n1 = 18;
  int n2 = 1;
  int n3 = 1;
  float hr = random(0.1,0.2);
  
  int m2 = int(random(1,28));
  int n12 = int(random(-1,1));
  int n22 = int(random(-100,100));
  int n32 = int(random(-60,60));
  int num = int(random(0,360));;
  
  
  
  
  Creature(int posX, int posY){
    
    x=posX;
    y=posY;
  
  
  }
  
  void update(){
    
    if(m!=m2){
      
      if(m>m2){
    
        m -= 0.5;
        
      }
      
      else  m+= 0.5;
    
    } else {
    
    m2 = int(random(1,28));
    
    }
    
     if(n1 != n12){
      
      if(n1>n12){
    
        n1--;
        
      }
      
      else  n1++;
    
    } else {
    
    n12 = int(random(-250,250));
    
    }
    
    
    if(n2 != n22){
      
      if(n2>n22){
    
        n2--;
        
      }
      
      else  n2++;
    
    } else {
    
    n22 = int(random(-100,100));
    
    }
    
    if(n3 != n32){
      
      if(n3>n32){
    
        n3--;
        
      }
      
      else  n3++;
    
    } else {
    
    n32 = int(random(-20,20));
    
    }
  }
    
  void display(){
    
    update();
    //stroke(255,127+127*sin(frameCount*this.hr));
    drawShape();
    
  }
  
  void drawShape(){
   
   pushMatrix();
   translate(x,y);
   
   float newscaler = scaler;
   
   for (int s=8; s>0; s--){
    
     beginShape();
     int mm=m+(2*s);
     int nn1 = n1 + s;
     int nn2 = n2 + s;
     int nn3 = n3 + s;
     newscaler = newscaler * 0.98;
     float sscaler = newscaler;
     
     PVector[] points = superformula ();
     
     curveVertex(points[points.length-1].x * sscaler, points[points.length-1].y*sscaler);
     
     for (int i=0; i<points.length;i++){
       curveVertex (points[i].x * sscaler,points[i].y * sscaler );
       
     }
     curveVertex(points[0].x * sscaler, points[0].y*sscaler);
     endShape();
     
   }
   
   popMatrix();
 
  
  }
  
 PVector[]  superformula (){

  int numPoints = 360;
  
  float phi = int(TWO_PI / numPoints);
  
  PVector[] points = new PVector[numPoints];
  
  for (int i =0 ; i< numPoints; i++){
    
    points [i]= superFormulaPoint(phi);
    
  }
  
  return points;

  
  }
  
  
  PVector superFormulaPoint ( float phi ){

  float r;
  float t1, t2;
  int a=1, b=1;
  float x=0;
  float y=0;
  
   t1=cos((m * phi) / 4) / a;
   t1 =abs(t1);
   t1 =pow(t1,n2);
  
   t2 =sin((m* phi) / 4) / b;
   t2 =abs(t2);
   t2 =pow(t2,n3);
  
   r = pow(t1+t2, 1/n1);
  
  if (abs(r)==0){
    x=0;
    y=0;
  }
  
  else {
    r= 1 / r;
    x= r * cos(phi);
    y= r * sin(phi);
  }
  
  PVector k = new PVector(x,y);
  return  k;
  
  
  }
  
  
  
  
  
  }
  
  
 
  





var scaler =200;



var c0;

function setup() {
  
 createCanvas(windowWidth, windowHeight);
 noFill();
 stroke(255,122);
 
 c0 = new Creature (windowWidth/2, windowHeight/2);
  c1 = new Creature (windowWidth/2, windowHeight/4);
}

function draw() {
  
  background(0);
 
  //c0.update();
  c0.display();
  //c1.display();
  
}

function Creature(x,y){
  this.x=x;
  this.y=y;
  
  this.m = 2;
  this.n1= 18;
  this.n2=1;
  this.n3 = 1;
  this.hr=random(0.1,0.2);
  
  this.m2 = Math.floor(random(1,28));
  this.n12= Math.floor(random(-1,1));
  this.n22=Math.floor(random(-100,100));
  this.n32 = Math.floor(random(-60,60));
  this.num= Math.floor(random(0,360));

  this.update = function(){
 
  if(this.m!=this.m2){
      
      if (this.m>this.m2){
        
        this.m-=0.5;
        
      }
      else
      
        this.m+=0.5;
      
     }
     else {
       
        this.m2 = Math.floor(random(1,28));
     }
     
     if(this.n1!=this.n12){
      
      if (this.n1>this.n12){
        
        this.n1--;
        
      }
      else
      
        this.n1++;
      
     }
     else {
       
        this.n12= Math.floor(random(-250,250));
     }
     
     
     if(this.n2!=this.n22){
      
      if (this.n2>this.n22){
        
        this.n2--;
        
      }
      else
      
        this.n2++;
      
     }
     else {
       
        this.n22= Math.floor(random(-100,100));
     }
     
     
      if(this.n3!=this.n32){
      
      if (this.n3>this.n32){
        
        this.n3--;
        
      }
      else
      
        this.n3++;
      
     }
     else {
       
        this.n32= Math.floor(random(-20,20));
     }
   
  }
  
  this.display = function(){
    
      this.update();
    //stroke(255,127+127*sin(frameCount*this.hr));
    drawShape(this.x, this.y,this.m,this.n1,this.n2, this.n3,this.num  );
    
  }
  
}

 function drawShape(x,y,m,n1,n2,n3,num){
   
   push();
   translate(x,y);
   
   var newscaler = scaler;
   
   for (var s=4; s>0; s--){
    
     beginShape();
     var mm=m+(2*s);
     var nn1 = n1 + s;
     var nn2 = n2 + s;
     var nn3 = n3 + s;
     newscaler = newscaler * 0.98;
     var sscaler = newscaler;
     
     var points = superformula (mm,nn1,nn2,nn3);
     
     curveVertex(points[points.length-1].x * sscaler, points[points.length-1].y*sscaler);
     
     for (var i=0; i<points.length;i++){
       curveVertex (points[i].x * sscaler,points[i].y * sscaler );
       
     }
     curveVertex(points[0].x * sscaler, points[0].y*sscaler);
     endShape();
     
   }
   
   pop();
   
 }

function superformula (m,n1,n2,n3,num){
  
  var numPoints =360;
  var phi = TWO_PI / numPoints
  var points = [];
  
  for (var i =0 ; i<= numPoints; i++){
    
    points [i]= superFormulaPoint(m,n1,n2,n3,phi*i);
    
  }
  
  return points;
  
}

function superFormulaPoint(m,n1,n2,n3,phi){
  
  var r;
  var t1, t2;
  var a=1, b=1;
  var x=0;
  var y=0;
  
  t1=cos((m * phi) / 4) / a;
  t1=abs(t1);
  t1=pow(t1,n2);
  
  t2=sin((m* phi) / 4) / b;
  t2=abs(t2);
  t2=pow(t2,n3);
  
  r = pow(t1+t2, 1/n1);
  
  if (abs(r)==0){
    x=0;
    y=0;
  }
  
  else {
    r= 1 / r;
    x= r * cos(phi);
    y= r* sin(phi);
  }
  
  return new p5.Vector(x,y);
  
}
function windowResized() {
    
  resizeCanvas(windowWidth, windowHeight);

}
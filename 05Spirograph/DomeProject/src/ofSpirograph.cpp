//
//  ofSpirograph.cpp
//  voodooDroneMachine
//
//  Created by Voodoo Noise on 16/09/15.
//
//

#include "ofSpirograph.h"

ofSpirograph::ofSpirograph()

{
    R=50;
    r=10;
    R2 =R/2;
    r2=r/45;
    f=1;
    t=0;
    
    theta=0;
    
    //ParametersForModulate
    
    spNum=3;
    RUp = 20;
    rUp = 100;
    
    den=10;
    inc=0.2;
    
    mesh.setMode(OF_PRIMITIVE_LINE_STRIP);
    
}

void ofSpirograph::update(){
    
   
    
    if (t==spNum){
        
        mesh.clear();
        t=0;
        // inc=ofRandom(0.1,0.2);
        
    }
    
    t++;
    
    R =ofRandom(-210,RUp);
    
    
    r=ofRandom(20,rUp);
    
    
    f=ofRandom(-1,1);
    
    alpha=0;
    
    z=ofRandom(-400,400);
    
    z=z2;
    
    
    
    while (abs(int(z-z2))<50) {
        z=ofRandom(-400,400);
        
    }
    
    for (theta=0; theta<720; theta+=0.1) {
        
        
        x= (R-r)*(cos(theta))+f*(r*(cos((R/r-1)*theta)))+ ofGetWidth()/2;
        
        y= (R-r)*(sin(theta))+f*(r*(sin((R/r-1)*theta)))+ ofGetHeight()/2;
        
        
        //alpha values 0.1 0.2 0.3 0.4
       
        alpha+=inc;
        //denominador z 1 2 4 8
        //mesh.addVertex(ofVec3f(x,y,z*sin(alpha)+z));
        
        //mesh.addVertex(ofVec3f(x,y,z/den*sin(alpha)+(z/1.5)));
        
       mesh.addVertex(ofVec3f(x,y,z));
    }
    
    
   
}

void ofSpirograph::draw(){
    
   // ofBackground(255, 255, 255);
    
    mesh.draw();
  
    
}
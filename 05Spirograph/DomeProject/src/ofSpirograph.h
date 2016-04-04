//
//  ofSpirograph.h
//  voodooDroneMachine
//
//  Created by Voodoo Noise on 16/09/15.
//
//

#ifndef __voodooDroneMachine__ofSpirograph__
#define __voodooDroneMachine__ofSpirograph__

#include <stdio.h>
#include "ofMain.h"



class ofSpirograph{
    
public:
    
    //methods
    void update();
    void draw();
    
    //constructor
    ofSpirograph();
    
    //variables
  
    float x;
    float y;
    float z;
    float z2;
    
    float R;
    float R2;
    float RUp;
   
    float r;
    float rUp;
    float r2;
    
    float inc;
    
    float f;
    
    float alpha;
    float theta;
    
    float den;
    
    int t;
    int spNum;
    
    //ofPolyline figure;
    
    ofMesh mesh;
    ofMesh mesh2;
    
    
    
    
private:
    
    
};


#endif /* defined(__voodooDroneMachine__ofSpirograph__) */

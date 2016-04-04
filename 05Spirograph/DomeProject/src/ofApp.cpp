#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofSetColor(0);
    //ofSetBackgroundAuto(false);
    ofBackground(255);
    
    ofSetLineWidth(0.0001);
    
    sphere.setScale(.5);
    sphere.setResolution(50);
    sphere.setPosition(0, 0, 0);
    sphere.setOrientation(ofVec3f(90,0,0));

    domemaster.setup();
    domemaster.setCameraPosition(0,0,10);
    
    ofSetFrameRate(0.5);
    
    
    mask.loadImage("domemaster/mask.png");
    mask.setUseTexture(true);
    
    
    mouseDisplacement = false;
    
    saver.init(10, 10, true);
    
    timer=0;
}

//--------------------------------------------------------------
void ofApp::update(){
    

    
    if (ofGetElapsedTimeMillis()-timer>8000){
        
  
        mySpirograph.update();
        
        timer = ofGetElapsedTimeMillis();
        
        saver.finish("frame_" + ofToString(ofGetFrameNum()) + ".png", true);
        
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
// mask.draw(0, 0, ofGetWidth(), ofGetHeight());
    

    saver.begin();
    
    mask.draw(0, 0, ofGetWidth(), ofGetHeight());

    drawScene();

    //ofEllipse(ofGetWidth()/2, ofGetHeight()/2, 200,200);
    
    saver.end();

   
}

//--------------------------------------------------------------
void ofApp::drawScene(){
   //sphere.drawWireframe();
 
    
    
    
     mySpirograph.draw();
    
    
  
 
}


//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    
    if(key=='s') saver.finish("frame_" + ofToString(ofGetFrameNum()) + "_high.png", true);
    
    
    

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
    sphere.setPosition(ofMap(x, 0, 1024, -25, 25), ofMap(y, 0, 1024, -25, 25), 5);
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}

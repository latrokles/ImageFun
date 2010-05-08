#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxiPhoneImagePicker.h"

class testApp : public ofxiPhoneApp {
	
public:	
	void setup();
	void update();
	void draw();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);

    void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    
    //-- UI methods, will move somewhere else later
    void loadPhoto();
    void takePhoto();
    void savePhoto();
    
    //-- Image Processing methods
    void restoreImg();
    void setThreshold(int value);
    void edgeDetection();
    void invert();
    void sharpen();
    void blur();
    void setPontilize();
    void pontilize();
    
    //Stores the image we are working on
    ofImage                photo;
    
    //Camera and Image Picker Vars
    unsigned char        * cameraPixels;       //for the camera flipping
    ofxiPhoneImagePicker * imagePicker;
    
    //keep a copy of original image
    unsigned char        * oldPixels;
    bool                   canRestore;
    float                  distance;
    
    //colors for edgedetection
    ofColor             fillColor;
    ofColor             edgeColor;
    
    //boolean to track if edge detection happened
    bool                edgeDetected;
    bool                doPontilize;
    bool                pontilized;
    
};



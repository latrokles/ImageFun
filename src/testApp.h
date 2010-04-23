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
    void invert();
    
    //Stores the image we are working on
    ofImage                photo;
    
    //Camera and Image Picker Vars
    unsigned char        * cameraPixels;       //for the camera flipping
    ofxiPhoneImagePicker * imagePicker;
};



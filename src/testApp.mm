#include "testApp.h"
#include "MyGuiView.h"

MyGuiView * myGuiViewController;


//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
		
	//NOTE WE WON'T RECEIVE TOUCH EVENTS INSIDE OUR APP WHEN THERE IS A VIEW ON TOP OF THE OF VIEW

    
	//Our Gui setup
	myGuiViewController	= [[MyGuiView alloc] initWithNibName:@"MyGuiView" bundle:nil];
	[ofxiPhoneGetUIWindow() addSubview:myGuiViewController.view];

	ofBackground(0,0,0);
    
    //Initializing stuff for Image Picker
    cameraPixels      = NULL;
    imagePicker       = new ofxiPhoneImagePicker();
    imagePicker->setMaxDimension(480);   //To avoid enormous images
}

//--------------------------------------------------------------
void testApp::update(){
    if(imagePicker->imageUpdated){
		
		// the pixels seem to be flipped, so let's unflip them: 
		if (cameraPixels == NULL){
			// first time, let's get memory based on how big the image is: 
			cameraPixels = new unsigned char [imagePicker->width * imagePicker->height*4];

		}
		// now, lets flip the image vertically:
		for (int i = 0; i < imagePicker->height; i++){
			memcpy(cameraPixels+(imagePicker->height-i-1)*imagePicker->width*4, imagePicker->pixels+i*imagePicker->width*4, imagePicker->width*4);
		}
		
		// finally, set the image from pixels...
        
		photo.setFromPixels(cameraPixels, imagePicker->width, imagePicker->height, OF_IMAGE_COLOR_ALPHA);
        photo.setImageType(OF_IMAGE_COLOR);
		imagePicker->imageUpdated=false;
        
	}
}

//--------------------------------------------------------------
void testApp::draw(){
	photo.draw(0, 0);
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){

	//IF THE VIEW IS HIDDEN LETS BRING IT BACK!
	if( myGuiViewController.view.hidden ){
		myGuiViewController.view.hidden = NO;
	}	
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

}

void testApp::lostFocus(){
    
}

void testApp::gotFocus(){
    
}

void testApp::gotMemoryWarning(){
    
}

void testApp::deviceOrientationChanged(int newOrientation){
    
}

void testApp::loadPhoto(){
    printf("Opening photo library\n");
    imagePicker->openLibrary();
    
}

void testApp::takePhoto(){
    printf("Opening Camera\n");
    imagePicker->openCamera();
}

void testApp::savePhoto(){
    printf("Saving Photo");
    
}
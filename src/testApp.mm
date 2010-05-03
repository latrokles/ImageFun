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
    
    //photo.loadImage("images/pic.JPG");
    
    canRestore = false;
    
    //set distance
    distance = 20;
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
		
		// turn RGBA image into a an RGB ofImage... this way I'll be able to manipulate it.
        unsigned char * newPixels = new unsigned char [imagePicker->width * imagePicker->height * 3];
        int newIndex = 0;
        for (int j=0; j < imagePicker->width * imagePicker->height * 4; j+=4) {
            newPixels[newIndex] = cameraPixels[j];
            newPixels[newIndex+1] = cameraPixels[j+1];
            newPixels[newIndex+2] = cameraPixels[j+2];
            newIndex +=3;
        }
        
		photo.setFromPixels(newPixels, imagePicker->width, imagePicker->height, OF_IMAGE_COLOR);
        oldPixels = new unsigned char[photo.width * photo.height * 3];
        // make a copy of the old pixels so that we can restore an image if we so desire
        memcpy(oldPixels, newPixels, photo.width * photo.height * 3 * sizeof(char));
        canRestore = true;
        imagePicker->imageUpdated=false;
	}
}

//--------------------------------------------------------------
void testApp::draw(){
	
    if (photo.getWidth() > photo.getHeight()) {
        //flip lansdcape image to display properly
        ofPushMatrix();
        ofTranslate(ofGetWidth(), 0, 0);
        ofRotateZ(90);
        photo.draw(0, 0);
        ofPopMatrix();
    }
    else {
        // draw protrait
        photo.draw(0, 0);
    }
    
    ofSetColor(0, 0, 255);
    ofFill();
    ofTriangle(ofGetWidth(), ofGetHeight(), ofGetWidth(), ofGetHeight() - 30, ofGetWidth() - 30, ofGetHeight());
    ofNoFill();
    ofSetColor(255, 255, 255);
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){

	//IF THE VIEW IS HIDDEN LETS BRING IT BACK!
    int x = touch.x;
    int y = touch.y;
	if( (x > ofGetWidth() - 30) && ( y > ofGetHeight() - 20) && myGuiViewController.view.hidden ){
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
    if (canRestore) {
        restoreImg();
    }
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
    //printf("Opening photo library\n");
    imagePicker->openLibrary();
    
}

void testApp::takePhoto(){
    //printf("Opening Camera\n");
    imagePicker->openCamera();
}

void testApp::savePhoto(){
    printf("Saving Photo not available now\n");
    ofxiPhoneAppDelegate * delegate = ofxiPhoneGetAppDelegate();
    ofxiPhoneScreenGrab(delegate);
}

void testApp::restoreImg(){
    photo.setFromPixels(oldPixels, photo.width, photo.height, OF_IMAGE_COLOR);
}

void testApp::setThreshold(int value){
    distance = value;
}

void testApp::edgeDetection(){
    restoreImg();
    int w = photo.getWidth();
    int h = photo.getHeight();
    
    unsigned char * edgePixels = photo.getPixels();
    canRestore = true;
    
    int r, g, b;
    int r1, g1, b1;
    int r2, g2, b2;
    
    
    for(int i = 0; i < w; i++)
    {
        for(int j = 0; j < h; j++)
        {
            r = edgePixels[(j*w+i)*3 + 0];
            g = edgePixels[(j*w+i)*3 + 1];
            b = edgePixels[(j*w+i)*3 + 2];
            
            r1 = edgePixels[(j*w+(i+1))*3 + 0];
            g1 = edgePixels[(j*w+(i+1))*3 + 1];
            b1 = edgePixels[(j*w+(i+1))*3 + 2];
            
            r2 = edgePixels[((j+1)*w+i)*3 + 0];
            g2 = edgePixels[((j+1)*w+i)*3 + 1];
            b2 = edgePixels[((j+1)*w+i)*3 + 2];
            
            if((sqrt((r-r1)*(r-r1) + (g-g1)*(g-g1) + (b-b1)*(b-b1)) >= distance) || 
               (sqrt((r-r2)*(r-r2) + (g-g2)*(g-g2) + (b-b2)*(b-b2)) >= distance))
            {
                //Draw the edge
                edgePixels[(j*w+i)*3 + 0] = 255;
                edgePixels[(j*w+i)*3 + 1] = 255;
                edgePixels[(j*w+i)*3 + 2] = 255;
            }
            else
            {
                //Draw fill
                edgePixels[(j*w+i)*3 + 0] = 0;
                edgePixels[(j*w+i)*3 + 1] = 0;
                edgePixels[(j*w+i)*3 + 2] = 0;
            }
        }
    }
    photo.setFromPixels(edgePixels, w, h, OF_IMAGE_COLOR);
}

void testApp::invert(){
    //printf("Inverting pixels\n");
    
    //-- iterate through the pixels and substract their value from 255, which gives me an inverted image
    unsigned char * pixels = photo.getPixels();
    for (int i=0; i<photo.width * photo.height * 3; i++) {
        pixels[i] = 255 - pixels[i];
    }
    photo.setFromPixels(pixels, photo.width, photo.height, OF_IMAGE_COLOR);
}
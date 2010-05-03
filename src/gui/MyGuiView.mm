#import "MyGuiView.h"
#include "ofxiPhoneExtras.h"


@implementation MyGuiView

// called automatically after the view is loaded, can be treated like the constructor or setup() of this class
-(void)viewDidLoad {
	myApp = (testApp*)ofGetAppPtr();
}

-(IBAction)takePhoto:(id)sender{
    myApp->takePhoto();
}

-(IBAction)loadPhoto:(id)sender{
    myApp->loadPhoto();
}

-(IBAction)savePhoto:(id)sender{
    myApp->savePhoto();
}

-(IBAction)updateThreshold:(id)sender{
    UISlider * thresholdSlider = (UISlider*)sender;
    int threshold = [thresholdSlider value];
    myApp->setThreshold(threshold);
    myApp->edgeDetection();
}

-(IBAction)edgeDetection:(id)sender{
    myApp->edgeDetection();
}

-(IBAction)invert:(id)sender{
    myApp->invert();
}
//----------------------------------------------------------------
-(IBAction)hide:(id)sender{
	self.view.hidden = YES;
}

@end

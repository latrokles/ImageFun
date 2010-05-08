#import <UIKit/UIKit.h>

#include "testApp.h"

@interface MyGuiView : UIViewController {
	testApp *myApp;		// points to our instance of testApp
}

-(IBAction)takePhoto:(id)sender;
-(IBAction)loadPhoto:(id)sender;
-(IBAction)savePhoto:(id)sender;

-(IBAction)updateThreshold:(id)sender;
-(IBAction)edgeDetection:(id)sender;
-(IBAction)sharpen:(id)sender;
-(IBAction)pontilize:(id)sender;
-(IBAction)invert:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)hide:(id)sender;

@end

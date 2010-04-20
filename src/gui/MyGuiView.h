#import <UIKit/UIKit.h>

#include "testApp.h"

@interface MyGuiView : UIViewController {
	testApp *myApp;		// points to our instance of testApp
}

-(IBAction)takePhoto:(id)sender;
-(IBAction)loadPhoto:(id)sender;
-(IBAction)savePhoto:(id)sender;

-(IBAction)hide:(id)sender;

@end

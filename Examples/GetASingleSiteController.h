//
//  GetASingleSiteController.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 

@interface GetASingleSiteController : UIViewController {
	IBOutlet UITextView *textView;
	IBOutlet UIButton *buttonGo;
	IBOutlet UITextField *inputField;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *buttonGo;
@property (nonatomic, retain) IBOutlet UITextField *inputField;

-(IBAction)getSingleSite;

@end
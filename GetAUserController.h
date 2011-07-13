//
//  GetAUserController.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/28/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetAUserController : UIViewController<UITextFieldDelegate> {

	IBOutlet UITextView *textView;
	IBOutlet UITextField *inputField;
	IBOutlet UIButton *buttonGo;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UITextField *inputField;
@property (nonatomic, retain) IBOutlet UIButton *buttonGo;

-(IBAction)getUser;

@end

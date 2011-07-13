//
//  CreateASiteController.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/27/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateASiteController : UIViewController {
	IBOutlet UITextView *textView;
	IBOutlet UITextField *inputName;
	IBOutlet UITextField *inputIsPrivate;
	IBOutlet UITextField *inputHostname;
	IBOutlet UIButton *createButton;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UITextField *inputName;
@property (nonatomic, retain) IBOutlet UITextField *inputIsPrivate;
@property (nonatomic, retain) IBOutlet UITextField *inputHostname;
@property (nonatomic, retain) IBOutlet UIButton *createButton;


-(IBAction)createSite;
@end

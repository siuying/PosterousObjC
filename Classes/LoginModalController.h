//
//  LoginModalController.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 7/3/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginModalController : UIViewController {
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextView *txtApiToken;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnCancel;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property(nonatomic, retain) IBOutlet UITextField *txtEmail;
@property(nonatomic, retain) IBOutlet UITextField *txtPassword;
@property(nonatomic, retain) IBOutlet UITextView *txtApiToken;
@property(nonatomic, retain) IBOutlet UIButton *btnSave;
@property(nonatomic, retain) IBOutlet UIButton *btnCancel;

-(IBAction)Save;
-(IBAction)Cancel;

@end
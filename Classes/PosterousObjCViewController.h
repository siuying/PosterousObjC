//
//  PosterousObjCViewController.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 8/6/10.
//  Copyright (c) 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterousClient.h"

@interface PosterousObjCViewController : UIViewController<UITableViewDelegate, UITextFieldDelegate> {
	
	NSMutableArray	*listOfMethods;
	IBOutlet UITableView *tableOfMethods;
    UIBarButtonItem *barLogin;

}

@property(nonatomic, retain) NSMutableArray *listOfMethods;
@property(nonatomic, retain) IBOutlet UITableView *tableOfMethods;
@property(nonatomic, retain) UIBarButtonItem *barLogin;

-(void)showLoginModal;

@end
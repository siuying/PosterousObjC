//
//  PosterousObjCAppDelegate.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 8/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@class PosterousObjCViewController;

@interface PosterousObjCAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;
	UINavigationController *navigationController; 
}

@property (nonatomic, retain) IBOutlet UIWindow *window; 
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


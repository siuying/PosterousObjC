//
//  PosterousObjCAppDelegate.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 8/6/10.
//  Copyright (c) 2010 . All rights reserved.
//


#import "PosterousObjCAppDelegate.h"

#import "PosterousObjCViewController.h"

@implementation PosterousObjCAppDelegate


@synthesize window;

@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
     
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)dealloc {

    [window release];
    [navigationController release];
    [super dealloc];
}

@end


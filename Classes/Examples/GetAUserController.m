    //
//  GetAUserController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/28/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import "GetAUserController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation GetAUserController

@synthesize textView, inputField, buttonGo;

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)getUser
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(loadAUser:)
     name:@"GetAUser"
     object:nil ];
    
	__block PosterousClient *client = [[PosterousClient alloc] initWithCredentials:EMAIL
																  password:PASSWORD 
																  apitoken:APITOKEN]; 
	
    GetAUserCompletionBlock complete = ^(User *user, NSError *error)
    {
        if (error) 
        {
            NSLog(@"GetASingleSite error: %@", [error userInfo]);
            textView.text = [error description];
        } 
        else
        {                
            textView.text = [NSString stringWithFormat:@"last_activity: %@\n nickname: %@\n _id: %@\n profile_pic: %@\n firstname: %@\n lastname: %@\n",
                             user.last_activity,user.nickname, user._id, user.profile_pic,user.firstname,user.lastname];
            
            [self.inputField resignFirstResponder];
        }
    };        
    
	PosterousRequest *request = [PosterousRequest alloc];
	request._id = inputField.text;
	[client GetAUser:request completionBlock:complete];	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
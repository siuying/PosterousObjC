    //
//  GetAUsersPrimarySiteController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/27/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import "GetAUsersPrimarySiteController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation GetAUsersPrimarySiteController

@synthesize textView;

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		
	PosterousClient *client = [[PosterousClient alloc] initWithCredentials:[Preferences getEmail]
																  password:[Preferences getPassword]
																  apitoken:[Preferences getAPIToken]]; 
	
    GetAUsersPrimarySiteCompletionBlock complete = ^(Site *site, NSError *error)
    {
        if (error) 
        {
            NSLog(@"GetASingleSite error: %@", [error userInfo]);
            textView.text = [error description];
        } 
        else
        {    
            Site *result = site;
            
            NSString *currentString = [NSString stringWithFormat:@"id: %@\n name: %@\n is_private: %@\n full_hostname: %@\n posts_url: %@\n posts_count: %@\n comment_persmission: %@",
                                       result._id,result.name,
                                       result.is_private,result.full_hostname,result.posts_url,
                                       result.posts_count, result.comment_permission];
            
            textView.text = currentString;
        }
    };
    
	PosterousRequest *request = [PosterousRequest alloc];
	[client GetAUsersPrimarySite:request completionBlock:complete];	
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
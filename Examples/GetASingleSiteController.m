    //
//  GetASingleSiteController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetASingleSiteController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation GetASingleSiteController

@synthesize textView, buttonGo, inputField;

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];}
*/

-(IBAction)getSingleSite
{    
	__block PosterousClient *client = [[PosterousClient alloc] initWithCredentials:[Preferences getEmail] 
																  password:[Preferences getPassword]
																  apitoken:[Preferences getAPIToken]]; 
	
    GetASingleSiteCompletionBlock complete = ^(Site *site, NSError *error)
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
	request._id = inputField.text;
    
	[client GetASingleSite: request completionBlock:complete];	
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
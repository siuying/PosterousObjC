    //
//  GetAUsersSitesController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetAUsersSitesController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation GetAUsersSitesController

@synthesize textView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	__block PosterousClient *client = [[PosterousClient alloc] initWithCredentials:EMAIL
																  password:PASSWORD
																  apitoken:APITOKEN];	 
	GetAUsersSitesCompletionBlock complete = ^(NSMutableArray *response, NSError *error)
    {
        if (error) 
        {
            NSLog(@"GetActivities error: %@", [error userInfo]);
            textView.text = [error description];
        } 
        else
        {
            NSMutableArray *sites = response;
            
            NSMutableString *output = [[NSMutableString alloc] init];
            
            for (int i = 0; i < [sites count];i++) {
                
                Site *result = [sites objectAtIndex:i];
                
                NSString *currentString = [NSString stringWithFormat:@"id: %@\n name: %@\n is_private: %@\n full_hostname: %@\n posts_url: %@\n posts_count: %@\n comment_persmission: %@",
                                           result._id,result.name,
                                           result.is_private,result.full_hostname,result.posts_url,
                                           result.posts_count, result.comment_permission];
                
                [output appendString:currentString];
            }	 
            
            textView.text = output;
        }
    };
    
    PosterousRequest *request = [PosterousRequest alloc];
    [client GetAUsersSites:request completionBlock:complete];
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
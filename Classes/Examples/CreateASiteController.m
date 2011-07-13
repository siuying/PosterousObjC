    //
//  CreateASiteController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/27/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import "CreateASiteController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation CreateASiteController

@synthesize textView, inputName, inputIsPrivate, inputHostname, createButton;

-(IBAction)createSite
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(loadCreateSiteResponse:)
     name:@"CreateASite"
     object:nil ];
    
	PosterousClient *client = [[PosterousClient alloc] initWithCredentials:EMAIL
																  password:PASSWORD
																  apitoken:APITOKEN]; 
	
	PosterousRequest *request = [PosterousRequest alloc];
	[client CreateASite:request];	
}

-(void)loadCreateSiteResponse:(NSNotification *)response
{
    Site *site = [response object];
    
    textView.text = [NSString stringWithFormat:@"id: %@\n name: %@\n is_private: %@\n full_hostname: %@\n posts_url: %@\n posts_count: %@\n comment_persmission: %@",
                     site._id,site.name,
					 site.is_private,site.full_hostname,site.posts_url,
					 site.posts_count,site.comment_permission];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

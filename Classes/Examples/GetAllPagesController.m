
//
//  GetAllPagesController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 6/11/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

#import "GetAllPagesController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation GetAllPagesController

@synthesize textView;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    PosterousClient *client = [[PosterousClient alloc] initWithCredentials:[Preferences getEmail]
																  password:[Preferences getPassword]
																  apitoken:[Preferences getAPIToken]]; 
    
    GetAllPagesCompletionBlock complete = ^(NSMutableArray *pages, NSError *error)
    {
        if (error) 
        {
            NSLog(@"GetAllPages error: %@", [error userInfo]);
            textView.text = [error description];
        } 
        else
        {    
            NSMutableString *output = [[NSMutableString alloc] init];
            
            for (Page *page in pages) 
            {  
               [output appendFormat:@"%@ \n",[page description]];
            }
            
            textView.text = output;
        }
    };    

	
	PosterousRequest *request = [PosterousRequest alloc];
	[client GetAllPages:request completionBlock:complete];	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
//
//  GetAllCommentsForAPostController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 6/29/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

#import "GetAllCommentsForAPostController.h"
#import "PosterousClient.h"
#import "Preferences.h"

@implementation GetAllCommentsForAPostController

@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    PosterousClient *client = [[PosterousClient alloc] initWithCredentials:EMAIL
																  password:PASSWORD
																  apitoken:APITOKEN]; 
    
    GetAllCommentsForAPostBlock complete = ^(NSMutableArray *comments, NSError *error)
    {
        if (error) 
        {
            NSLog(@"GetAllCommentsForAPost error: %@", [error userInfo]);
            textView.text = [error description];
        } 
        else
        {    
            NSMutableString *output = [[NSMutableString alloc] init];
            
            //for (Page *page in comments) 
            //{  
              //  [output appendFormat:@"%@ \n",[page description]];
            //}
            
            textView.text = output;
        }
    };    
    
	
	PosterousRequest *request = [PosterousRequest alloc];
	[client GetAllCommentsForAPost:request completionBlock:complete];	
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

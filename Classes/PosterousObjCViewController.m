//
//  PosterousObjCViewController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 8/6/10.
//  Copyright (c) 2010. All rights reserved.
//

#import "PosterousObjCViewController.h"
#import "PosterousClient.h"
#import "GetAUsersSitesController.h"
#import "GetASingleSiteController.h"
#import "GetAUsersPrimarySiteController.h"
#import "CreateASiteController.h"
#import "GetAUserController.h"
#import "UIColor+DigitalColorMeter.h"
#import "LoginModalController.h"

@implementation PosterousObjCViewController

@synthesize listOfMethods, tableOfMethods, barLogin;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[listOfMethods allValues] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier] autorelease];
	}	
    
    if ([[[listOfMethods allValues] objectAtIndex:indexPath.row] isEqualToString:@"1"]) 
         cell.imageView.image = [UIImage imageNamed:@"greendot.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"reddot.png"];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.font = [UIFont fontWithName:@"Georgia" size:20];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.text = [[listOfMethods allKeys]objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *methodCall = [[listOfMethods allKeys] objectAtIndex:indexPath.row];
	     
    NSString *className = [methodCall stringByAppendingString:@"Controller"];
    
    UIViewController *controller = [[NSClassFromString(className) alloc] initWithNibName:methodCall bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    [tableOfMethods deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)showLoginModal
{
    LoginModalController *loginModalController = [[LoginModalController alloc] initWithNibName:@"LoginModalController" bundle:nil];     
    loginModalController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController presentModalViewController:loginModalController animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *credentials = [prefs objectForKey:@"credentials"];
    
    if (credentials == nil) 
    {
        [self performSelector:@selector(showLoginModal) withObject:nil afterDelay:0.1];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Credentials" style:UIBarButtonItemStyleBordered target:self action:@selector(showLoginModal)];
    
    self.navigationController.navigationBar.tintColor  = [UIColor colorWithDigitalColorMeterString:@"22.0	18.4	14.9"];
    
    self.tableOfMethods.backgroundColor = [UIColor colorWithDigitalColorMeterString:@"82.4	78.8	74.9"];
	listOfMethods = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"GetAUsersSites",@"1",@"GetASingleSite",
         @"1",@"GetASingleSite",
         @"1",@"GetAUsersPrimarySite",
         @"0",@"CreateASite",
         @"0",@"DeleteASite",
         @"0",@"GetASitesSubcribers",
         @"0",@"SubscribeToASite",
         @"0",@"UnsubscribeToASite",
         @"1",@"GetAUser",
         @"0",@"GetAUsersSubscribedSites",
         @"0",@"GetPublicPostsFromPrimarySite",
         @"0",@"GetPublicPostsFromSiteByHostname",
         @"0",@"GetPublicPostsFromASiteOrID",
         @"0",@"GetPublicPostsFromAnotherUser",
         @"0",@"GetAllPostsForASite",
         @"0",@"CreateAPost",
         @"0",@"UpdateAPost",
         @"0",@"DeleteAPost",
         @"1",@"GetAllPages",
         @"0",@"GetASinglePage",
         @"0",@"CreateAPage",
         @"0",@"UpdateAPage",
         @"0",@"GetAllCommentsForAPost",
         @"0",@"CreateAComment",
         @"0",@"DeleteAComment",
         @"0",@"GetASitesTheme",
         @"0",@"UploadPhoto",
         @"0",@"GetPostByShortCode",nil];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
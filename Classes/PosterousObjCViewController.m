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
	return [listOfMethods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier] autorelease];
	}	
    
    NSMutableDictionary *currentDictionary = [listOfMethods objectAtIndex:indexPath.row];
    
    if ([[[currentDictionary allKeys] objectAtIndex:0] isEqualToString:@"1"]) 
         cell.imageView.image = [UIImage imageNamed:@"greendot.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"reddot.png"];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.font = [UIFont fontWithName:@"Georgia" size:20];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.text = [[currentDictionary allValues]objectAtIndex:0];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableDictionary *currentDictionary = [listOfMethods objectAtIndex:indexPath.row];
	NSString *methodCall = [[currentDictionary allValues] objectAtIndex:0];
	     
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
    
    self.listOfMethods = [[NSMutableArray alloc] initWithObjects:
                          [NSMutableDictionary dictionaryWithObject:@"GetAUsersSites" forKey:@"1"],
                          [NSMutableDictionary dictionaryWithObject:@"GetASingleSite" forKey:@"1"],
                          [NSMutableDictionary dictionaryWithObject:@"GetAUsersPrimarySite" forKey:@"1"],
                          [NSMutableDictionary dictionaryWithObject:@"GetAUser" forKey:@"1"],
                          [NSMutableDictionary dictionaryWithObject:@"GetAllPages" forKey:@"1"],
                          [NSMutableDictionary dictionaryWithObject:@"CreateASite" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"DeleteASite" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetASitesSubcribers" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"SubscribeToASite" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"UnsubscribeToASite" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetAUsersSubscribedSites" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetPublicPostsFromPrimarySite" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetPublicPostsFromSiteByHostname" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetPublicPostsFromASiteOrID" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetPublicPostsFromAnotherUser" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetAllPostsForASite" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"CreateAPost" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"UpdateAPost" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"DeleteAPost" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetASinglePage" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"CreateAPage" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"UpdateAPage" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetAllCommentsForAPost" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"CreateAComment" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"DeleteAComment" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetASitesTheme" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"UploadPhoto" forKey:@"0"],
                          [NSMutableDictionary dictionaryWithObject:@"GetPostByShortCode" forKey:@"0"],nil];
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
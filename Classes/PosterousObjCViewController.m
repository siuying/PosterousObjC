/*
 
 Copyright (c) 2010-2011, Josh Grenon
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of the Josh Grenon nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

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
    
    UIViewController *controller = [[[NSClassFromString(className) alloc] initWithNibName:methodCall bundle:nil] autorelease];
    
    [self.navigationController pushViewController:controller animated:YES];
    [tableOfMethods deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)showLoginModal
{
    LoginModalController *loginModalController = [[[LoginModalController alloc] initWithNibName:@"LoginModalController" bundle:nil] autorelease];     
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
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Credentials" style:UIBarButtonItemStyleBordered target:self action:@selector(showLoginModal)] autorelease];
    
    self.navigationController.navigationBar.tintColor  = [UIColor colorWithDigitalColorMeterString:@"22.0	18.4	14.9"];
    
    self.tableOfMethods.backgroundColor = [UIColor colorWithDigitalColorMeterString:@"82.4	78.8	74.9"];
    
    self.listOfMethods = [[[NSMutableArray alloc] initWithObjects:
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
                          [NSMutableDictionary dictionaryWithObject:@"GetPostByShortCode" forKey:@"0"],nil] autorelease];
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
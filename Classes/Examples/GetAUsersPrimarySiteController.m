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
		
	PosterousClient *client = [[[PosterousClient alloc] initWithCredentials:EMAIL
																  password:PASSWORD
																  apitoken:APITOKEN] autorelease]; 
	
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
    
	PosterousRequest *request = [[[PosterousRequest alloc] init] autorelease];
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
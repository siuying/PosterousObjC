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

#import "LoginModalController.h"
#import "UIColor+DigitalColorMeter.h"

@implementation LoginModalController

@synthesize txtEmail,txtPassword,txtApiToken;
@synthesize btnSave,btnCancel;
@synthesize navBar;

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

-(IBAction)Save
{    
    NSMutableDictionary *credentials = [NSMutableDictionary dictionaryWithObjectsAndKeys:txtEmail.text,@"email",txtPassword.text,@"password",txtApiToken.text,@"apitoken", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:credentials forKey:@"credentials"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)Cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navBar.tintColor = [UIColor colorWithDigitalColorMeterString:@"98.0	92.5	64.7"];
    self.view.backgroundColor = [UIColor colorWithDigitalColorMeterString:@"81.6	78.8	74.5"];
    
    NSMutableDictionary *credentials = [[NSUserDefaults standardUserDefaults] objectForKey:@"credentials"];
    
    if (credentials) 
    {
        txtEmail.text = [credentials objectForKey:@"email"];
        txtPassword.text = [credentials objectForKey:@"password"];
        [txtApiToken setText:[credentials objectForKey:@"apitoken"]];
    }
    
    if ([txtApiToken.text isEqualToString:@""]) 
    {
        txtApiToken.text = @"ApiToken";
        txtApiToken.textColor = [UIColor lightGrayColor];
        txtApiToken.font = [UIFont fontWithName:@"Georgia" size:12];
    }
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    
    for (UIView* view in self.view.subviews) 
    {        
        if (![view isKindOfClass:[UITextField class]])      
        {
            [txtEmail resignFirstResponder];        
            [txtPassword resignFirstResponder]; 
            [txtApiToken resignFirstResponder]; 
        }
    }
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
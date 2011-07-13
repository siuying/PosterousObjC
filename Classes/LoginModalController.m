//
//  LoginModalController.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 7/3/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

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
    NSMutableDictionary *credentials = [NSMutableDictionary dictionaryWithObjectsAndKeys:txtEmail.text,@"email",txtPassword.text,@"password",txtApiToken.text,@"apitoken", nil];//[prefs objectForKey:@"credentials"];
    [[NSUserDefaults standardUserDefaults] setObject:credentials forKey:@"credentials"];
    
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
    
    if (credentials != nil) 
    {
        txtEmail.text = [credentials objectForKey:@"email"];
        txtPassword.text = [credentials objectForKey:@"password"];
        txtApiToken.text = [credentials objectForKey:@"apitoken"];
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
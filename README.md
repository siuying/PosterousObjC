## PosterousObjC ##
An Objective-C Library(with examples) for the Posterous 2.0 API

<img src="https://github.com/joshgrenon/PosterousObjC/raw/master/screenshot.png" alt="screenshot" />

#How to import PosterousObjC into your project

1. Download PosterousObjC source to your computer

2. Locate folder "PosterousClient" under "PosterousObjC/Classes". Drag and drop it into your project. A dialog will appear -- make sure "Copy items" is checked, "Recursively create groups for any added folders" radio button is selected, "Reference Type" is "Default" before clicking "Add".

3. Right click on the "Frameworks" group in your project and select Add > Existing Frameworks. Then locate the following frameworks and add them to the project (if they do not already exist in your application) 
    - CFNetwork 
    - SystemConfiguration
    - MobileCoreServices
    - CoreGraphics
    - libz.1.2.3.dylib


#Calling PosterousObjC methods in your project

1. Import PosterousClient.h in the header class of the controller that will use this library.

        import "PosterousClient.h"

2. Create an instance of PosterousClient within your method

GetAUsersPrimarySite example code
Note: You will need to set EMAIL, PASSWORD, APITOKEN (located at the top of the PosterousClient.h) to your Posterous email, password, and apitoken before using this library in your project.
    
    PosterousClient *client = [[PosterousClient alloc] initWithCredentials:EMAIL
																  password:PASSWORD
																  apitoken:APITOKEN];
	
3. Call a Posterous Client method within the same method you created an instance of PosterousClient:

GetAUsersPrimarySite example code

    GetAUsersPrimarySiteCompletionBlock complete = ^(Site *site, NSError *error)
    {
        if (error) 
        {
            NSLog(@"GetASingleSite error: %@", [error userInfo]);
        } 
        else
        {    
            Site *result = site;
        
    		NSString *siteString = [NSString stringWithFormat:@"id: %@\n name: %@\n is_private: %@\n full_hostname: %@\n posts_url: %@\n posts_count: %@\n comment_persmission: %@",
                                   result._id,result.name,
                                   result.is_private,result.full_hostname,result.posts_url,
                                   result.posts_count, result.comment_permission];
        
    							NSLog(@"site: %@",siteString);
        }
    };

    PosterousRequest *request = [PosterousRequest alloc];
    [client GetAUsersPrimarySite:request completionBlock:complete];
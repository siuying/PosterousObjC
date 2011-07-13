//
//  PosterousClient.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PosterousClient.h"
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"
#import "ASIFormDataRequest.h"

@interface PosterousClient()

@property(nonatomic, copy) GetAUsersSitesCompletionBlock getAUsersSitesCompletionBlock;
@property(nonatomic, copy) GetASingleSiteCompletionBlock getASingleSiteCompletionBlock;
@property(nonatomic, copy) GetAUsersPrimarySiteCompletionBlock getAUsersPrimarySiteCompletionBlock;
@property(nonatomic, copy) GetAUserCompletionBlock getAUserCompletionBlock;
@property(nonatomic, copy) GetAllPagesCompletionBlock getAllPagesCompletionBlock;
@property(nonatomic, copy) GetAllCommentsForAPostBlock getAllCommentsForAPostBlock;

@end

@implementation PosterousClient

@synthesize _username;
@synthesize _apitoken;
@synthesize _password; 

@synthesize getAUsersSitesCompletionBlock;
@synthesize getASingleSiteCompletionBlock;
@synthesize getAUsersPrimarySiteCompletionBlock;
@synthesize getAUserCompletionBlock;
@synthesize getAllPagesCompletionBlock;
@synthesize getAllCommentsForAPostBlock;

-(PosterousClient*) initWithCredentials: (NSString *) username 
							   password: (NSString *) password	
							   apitoken: (NSString *) apitoken
{
	self = [super init];
    if ( self ) {		
		
		_username = username;
		_password = password;
		_apitoken = apitoken;
	}
	
	return self;
}

//GetAUsersSites section
-(void)GetAUsersSites:(PosterousRequest *) requestObject completionBlock:(GetAUsersSitesCompletionBlock)completion
{	
    getAUsersSitesCompletionBlock = [completion copy];     
	NSString * const Sites_GetAUsersSites = @"http://posterous.com/api/2/users/me/sites";
	
    //Request paramaters: 0
	//Response type: an array of Site objects
	NSString *urlWithAPIToken = [Sites_GetAUsersSites stringByAppendingFormat:@"?api_token=%@",_apitoken];
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
	 
	__block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setUsername:_username];
    [request setPassword:_password]; 
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];        
        NSMutableArray *responseArray = [NSMutableArray array];
        
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSArray *resultsDictionary = [jsonDeserializer deserializeAsArray:responseData error:&error1];
        
        if ([resultsDictionary count] > 0) 
        {
            for (NSDictionary *node in resultsDictionary) 
            {                
                Site *site = [Site alloc];
                site._id =  [[node objectForKey:@"id"] stringValue];
                site.name = [node objectForKey:@"name"];
                site.full_hostname = [node objectForKey:@"full_hostname"]; 
                site.posts_url = [node objectForKey:@"posts_url"];  
                site.is_private = [node objectForKey:@"is_private"];  
                site.posts_count = [node objectForKey:@"primary"];
                site.comment_permission = [node objectForKey:@"comment_permission"];
                [responseArray addObject:site];		
            }	
        }
         
        if (self.getAUsersSitesCompletionBlock) 
            self.getAUsersSitesCompletionBlock(responseArray, nil);
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];
}
//end GetAUsersSites section

//GetASingleSite section
-(void)GetASingleSite:(PosterousRequest *) requestObject completionBlock:(GetASingleSiteCompletionBlock)completion
{		
    getASingleSiteCompletionBlock = [completion copy];  
    
	//NSString * const Sites_GetSingleSite = @"http://posterous.com/api/2/users/me/sites/"
	NSMutableString *apiURL = [[NSMutableString alloc] initWithString: @"http://posterous.com/api/2/users/me/sites/"];
    	
	if (requestObject._id != nil) 
	{
		[apiURL appendString:requestObject._id];
	}
	else if(requestObject.hostname != nil) 
	{
		[apiURL appendString:requestObject.hostname];
	}
	else if(requestObject.primary != nil)
	{
		[apiURL appendString:requestObject.primary];
	}
		
	NSString *urlWithAPIToken = [apiURL stringByAppendingFormat:@"?api_token=%@",_apitoken];
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setUsername:_username];
    [request setPassword:_password]; 
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];
        
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:responseData error:&error1];
        
        if(resultsDictionary != nil)
        {					
            Site *site = [Site alloc];
            site._id =  [[resultsDictionary objectForKey:@"id"] stringValue];
            site.name = [resultsDictionary objectForKey:@"name"];
            site.full_hostname = [resultsDictionary objectForKey:@"full_hostname"]; 
            site.posts_url = [resultsDictionary objectForKey:@"posts_url"];  
            site.is_private = [resultsDictionary objectForKey:@"is_private"];  
            site.posts_count = [resultsDictionary objectForKey:@"primary"];
            site.comment_permission = [resultsDictionary objectForKey:@"comment_permission"];
            
            if (self.getASingleSiteCompletionBlock) 
                self.getASingleSiteCompletionBlock(site, nil);
        }	
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];	
}
//end GetASingleSite section

//GetAUsersPrimarySite section
-(void)GetAUsersPrimarySite:(PosterousRequest *) requestObject completionBlock:(GetAUsersPrimarySiteCompletionBlock)completion
{
    getAUsersPrimarySiteCompletionBlock = [completion copy];  
	NSString * const Sites_GetAUsersPrimarySite = @"http://posterous.com/api/2/users/me/sites/primary";
    
	//Request paramaters: 0
	//Response type: one Site object
	NSString *urlWithAPIToken = [Sites_GetAUsersPrimarySite stringByAppendingFormat:@"?api_token=%@",_apitoken];
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
	
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setUsername:_username];
    [request setPassword:_password]; 
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];
        
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:responseData error:&error1];
        
        if(resultsDictionary != nil)
        {					
            Site *site = [Site alloc];
            site._id =  [[resultsDictionary objectForKey:@"id"] stringValue];
            site.name = [resultsDictionary objectForKey:@"name"];
            site.full_hostname = [resultsDictionary objectForKey:@"full_hostname"]; 
            site.posts_url = [resultsDictionary objectForKey:@"posts_url"];  
            site.is_private = [resultsDictionary objectForKey:@"is_private"];  
            site.posts_count = [resultsDictionary objectForKey:@"primary"];
            site.comment_permission = [resultsDictionary objectForKey:@"comment_permission"];
            
            if (self.getAUsersPrimarySiteCompletionBlock) 
                self.getAUsersPrimarySiteCompletionBlock(site, nil);
        }	
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];
}
//end GetAUsersPrimarySite section 

-(void)CreateASite:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement CreateASite method");
    
	/*NSString * const Sites_CreateASite = @"http://posterous.com/api/2/users/me/sites";
	NSString *urlWithAPIToken = [Sites_CreateASite stringByAppendingFormat:@"?api_token=%@",_apitoken];
	NSLog(@"%@",urlWithAPIToken);
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
	
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setUsername:_username];
    [request setPassword:_password]; 
    [request addPostValue:@"my awesome sit1e" forKey:@"name"];
    [request addPostValue:@"false" forKey:@"is_private"];
    [request addPostValue:@"joshgrenon" forKey:@"hostname"];
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];
                 
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:responseData error:&error1];
        
        if(resultsDictionary != nil)
        {					
            Site *site = [Site alloc];
            site._id =  [[resultsDictionary objectForKey:@"id"] stringValue];
            site.name = [resultsDictionary objectForKey:@"name"];
            site.full_hostname = [resultsDictionary objectForKey:@"full_hostname"]; 
            site.posts_url = [resultsDictionary objectForKey:@"posts_url"];  
            site.is_private = [resultsDictionary objectForKey:@"is_private"];  
            site.posts_count = [resultsDictionary objectForKey:@"primary"];
            site.comment_permission = [resultsDictionary objectForKey:@"comment_permission"];
            response.site = site;				  	
        }	
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];*/
}

-(void)DeleteASite:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement DeleteASite method");
    
//	NSString * const Sites_DeleteASite = @"http://posterous.com/api/2/users/me/sites";//id or hostname
//	//Request paramaters: id, hostname or primary 
//	///site to delete: 1850381
//	//TODO: add id or hostname paramater to url when building post object
//	
//	NSString *urlWithAPIToken = [@"http://posterous.com/api/2/users/me/sites" stringByAppendingFormat:@"?api_token=%@",_apitoken];
//	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
//	
//	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//	[request setRequestMethod:@"DELETE"];
//	[request setUsername:_username];
//	[request setPassword:_password];  	  
//	[request setDelegate:self];
//	[request startAsynchronous];
}

-(void)GetASitesSubcribers:(PosterousRequest *) requestObject
{ 	
    NSAssert(0, @"TODO:implement GetASitesSubcribers method");
    
//	NSString *const Sites_GetSitesSubscribers = @"http://posterous.com/api/2/users/1/sites/primary/subscribers";
//	
//	//Response type: an array of Subscriber objects	
//	NSString *urlWithAPIToken = [Sites_GetSitesSubscribers stringByAppendingFormat:@"?api_token=%@",_apitoken];
//	NSLog(@"%@", urlWithAPIToken);
//	NSURL *url = [NSURL URLWithString:urlWithAPIToken]; 
}

-(void)SubscribeToASite:(PosterousRequest *) requestObject
{	
    NSAssert(0, @"TODO:implement SubscribeToASite method");
	//NSString *const Sites_SubscribeToSite = @"http://posterous.com/api/2/users/1/sites/primary/subscribe";
}

-(void)UnsubscribeToASite:(PosterousRequest *) requestObject
{	
    NSAssert(0, @"TODO:implement UnsubscribeToASite method");
	//NSString *const Sites_UnSubscribeFromSite = @"http://posterous.com/api/2/users/1/sites/primary/unsubscribe";
}
 
//Users methods
-(void)GetAUser:(PosterousRequest *) requestObject completionBlock: (GetAUserCompletionBlock)completion
{	
    getAUserCompletionBlock = [completion copy];
	NSMutableString *apiURL = [[NSMutableString alloc] initWithString: @"http://posterous.com/api/2/users/"];
	
	if (requestObject._id != nil) 
	{
		[apiURL appendString:requestObject._id];
	}
	 
	NSString *urlWithAPIToken = [apiURL stringByAppendingFormat:@"?api_token=%@",_apitoken];
	
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
	
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setUsername:_username];
    [request setPassword:_password]; 
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];
        
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:responseData error:&error1];
        
        if(resultsDictionary != nil)
        {				
            User *user = [User alloc];
            user.last_activity = [resultsDictionary objectForKey:@"last_activity"];
            user.nickname = [resultsDictionary objectForKey:@"nickname"];
            user.lastname = [resultsDictionary objectForKey:@"lastname"];
            user._id = [[resultsDictionary objectForKey:@"id"] stringValue];
            user.profile_pic = [resultsDictionary objectForKey:@"profile_pic"];
            user.firstname = [resultsDictionary objectForKey:@"firstname"];
          	
            if (self.getAUserCompletionBlock) 
                self.getAUserCompletionBlock(user, nil);
        }	
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];
}

-(void)GetAUsersSubscribedSites:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetAUsersSubscribedSites method");
	//NSString *const Users_GetAUsersSubscribedSites = @"http://posterous.com/api/2/users/me/subscriptions";
}

-(void)GetPublicPostsFromPrimarySite:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetPublicPostsFromPrimarySite method");
	//NSString *const Posts_GetPublicPostsFromPrimarySite = @"http://posterous.com/api/2/users/me/sites/primary/posts/public";	
}

-(void)GetPublicPostsFromSiteByHostname:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetPublicPostsFromSiteByHostname method");
	//NSString *const Posts_GetPublicPostsFromSiteByHostname = @"http://posterous.com/api/2/users/me/sites/twoism/posts/public";
}

-(void)GetPublicPostsFromASiteOrID:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetPublicPostsFromASiteOrID method");
	//NSString *const Posts_GetPublicPostsFromASiteOrID = @"http://posterous.com/api/2/users/me/sites/12345/posts/public";
}

-(void)GetPublicPostsFromAnotherUser:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetPublicPostsFromAnotherUser method");
	//NSString *const Posts_GetPublicPostsFromAnotherUser = @"http://posterous.com/api/2/users/12345/sites/twoism/posts/public";
}

-(void)GetAllPostsForASite:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetAllPostsForASite method");
	//NSString *const Posts_GetAllPostsForASite = @"http://posterous.com/api/2/users/me/sites/<primary or id>/posts"	
}

-(void)GetASinglePost:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetASinglePost method");
	//NSString *const Posts_GetASinglePost = @"http://posterous.com/api/2/users/me/sites/<primary or id>/posts/< id >";	
}

-(void)CreateAPost:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement CreateAPost method");
	//NSString *const Posts_CreateAPost = @"http://posterous.com/api/2/users/me/sites/primary/posts";
}

-(void)UpdateAPost:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement UpdateAPost method");
	//NSString *const Posts_UpdateAPost = @"http://posterous.com/api/2/users/me/sites/primary/posts/< id >";	
}

-(void)DeleteAPost:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement DeleteAPost method");
	//NSString *const Posts_DeleteAPost = @"http://posterous.com/api/2/users/me/sites/primary/posts/< id >";	
}

//Pages methods
-(void)GetAllPages:(PosterousRequest *) requestObject completionBlock: (GetAllPagesCompletionBlock)completion
{
    getAllPagesCompletionBlock = [completion copy];    
    NSMutableString *apiURL = [[NSMutableString alloc] initWithString: @"http://posterous.com/api/2/users/me/sites/914165/pages"];
    
    NSString *urlWithAPIToken = [apiURL stringByAppendingFormat:@"?api_token=%@",_apitoken];
	
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
	
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setUsername:_username];
    [request setPassword:_password]; 
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];
        NSMutableArray *pages = [NSMutableArray array];
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]; 
        NSLog(@"GetAllPages data: %@",responseString);
                
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSArray *results = [jsonDeserializer deserializeAsArray:responseData error:&error1];
        NSLog(@"error1: %@",[error1 description]);
        if(results != nil)
        {	            
            for (NSDictionary *node in results) 
            {        
               Page *page = [[Page alloc] init:node];
               [pages addObject:page];	
            }
            
            if (self.getAllPagesCompletionBlock) 
                self.getAllPagesCompletionBlock(pages, nil);
        }	
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];
}

-(void)GetASinglePage:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetASinglePage method");
	//NSString *const Pages_GetASinglePage = @"http://posterous.com/api/2/users/me/sites/1/pages/< id >";	
}

-(void)CreateAPage:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement CreateAPage method");
	//NSString *const Pages_CreateAPage = @"http://posterous.com/api/2/users/me/sites/1/pages";
}

-(void)UpdateAPage:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement UpdateAPage method");
	//NSString *const Pages_UpdateAPage = @"http://posterous.com/api/2/users/me/sites/1/pages/< id >";
}

-(void)DeleteAPage:(PosterousRequest *) requestObject
{	
    NSAssert(0, @"TODO:implement DeleteAPage method");
	//NSString *const Pages_UpdateAPage = @"http://posterous.com/api/2/users/me/sites/1/pages/< id >";
}

//Comments methods
-(void)GetAllCommentsForAPost:(PosterousRequest *) requestObject completionBlock: (GetAllCommentsForAPostBlock)completion
{
	//NSString *const Comments_GetAllCommentsForAPost = @"http://posterous.com/api/2/users/me/sites/primary/posts/1/comments";
    getAllCommentsForAPostBlock = [completion copy];  
    
	NSMutableString *apiURL = [[NSMutableString alloc] initWithString: @"http://posterous.com/api/2/users/me/sites/primary/posts/58975206/comments"];
    
//	if (requestObject._id != nil) 
//	{
//		[apiURL appendString:requestObject._id];
//	}
//	else if(requestObject.hostname != nil) 
//	{
//		[apiURL appendString:requestObject.hostname];
//	}
//	else if(requestObject.primary != nil)
//	{
//		[apiURL appendString:requestObject.primary];
//	}
    
	NSString *urlWithAPIToken = [apiURL stringByAppendingFormat:@"?api_token=%@",_apitoken];
	NSURL *url = [NSURL URLWithString:urlWithAPIToken];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setUsername:_username];
    [request setPassword:_password]; 
	[request setCompletionBlock:^{        
        
        NSData *responseData = [request responseData];
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]; 
        NSLog(@"GetAllCommentsForAPost data: %@",responseString);
        
        NSError *error1 = nil;
        CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
        
        NSMutableArray *results = (NSMutableArray *)[jsonDeserializer deserializeAsArray:responseData error:&error1];
        //NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:responseData error:&error1];
        
        if(results != nil)
        {					
//            Site *site = [Site alloc];
//            site._id =  [[resultsDictionary objectForKey:@"id"] stringValue];
//            site.name = [resultsDictionary objectForKey:@"name"];
//            site.full_hostname = [resultsDictionary objectForKey:@"full_hostname"]; 
//            site.posts_url = [resultsDictionary objectForKey:@"posts_url"];  
//            site.is_private = [resultsDictionary objectForKey:@"is_private"];  
//            site.posts_count = [resultsDictionary objectForKey:@"primary"];
//            site.comment_permission = [resultsDictionary objectForKey:@"comment_permission"];
            
            if (self.getAllCommentsForAPostBlock) 
                self.getAllCommentsForAPostBlock(results, nil);
        }	
	}];
	[request setFailedBlock:^{
		NSError *error = [request error];
		NSLog(@"error: %@", [error userInfo]);
	}];
	[request startAsynchronous];
}
-(void)CreateAComment:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement CreateAComment method");
	//NSString *const Comments_CreateAComment = @"http://posterous.com/api/2/users/me/sites/primary/posts/1/comments";
}

-(void)DeleteAComment:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement DeleteAComment method");
	//NSString *const Comments_DeleteAComment = @"http://posterous.com/api/2/users/me/sites/primary/posts/1/comments/1";
}

//Theme methods
-(void)GetASitesTheme:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetASitesTheme method");
	//NSString *const Theme_GetASitesTheme = @"http://posterous.com/api/2/users/me/sites/1/theme";		
}

//Twitter methods
-(void)UploadPhoto:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement UploadPhoto method");
	//NSString *const Comments_DeleteAComment = @"http://posterous.com/api2/upload.format";
}

//Post.ly
-(void)GetPostByShortCode:(PosterousRequest *) requestObject
{
    NSAssert(0, @"TODO:implement GetPostByShortCode method");
	//NSString *const Postly_GetPostByShortCode = @"http://posterous.com/api/getpost";	
}

@end
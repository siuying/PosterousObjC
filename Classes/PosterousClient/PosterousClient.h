//
//  PosterousClient.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/25/10.
// Copyright (c) 2010 MotionMobs (http://motionmobs.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#define EMAIL [Preferences getEmail]
#define PASSWORD [Preferences getPassword]
#define APITOKEN [Preferences getAPIToken]

#import <Foundation/Foundation.h>
#import "PosterousRequest.h"
#import "Site.h"
#import "Page.h"
#import "User.h"

typedef void (^GetAUsersSitesCompletionBlock)(NSMutableArray *posterousClient, 
                                             NSError *error);
typedef void (^GetASingleSiteCompletionBlock)(Site *site,NSError *error);
typedef void (^GetAUsersPrimarySiteCompletionBlock)(Site *site,NSError *error);
typedef void (^GetAUserCompletionBlock)(User *site,NSError *error);
typedef void (^GetAllPagesCompletionBlock)(NSMutableArray *pages, NSError *error);
typedef void (^GetAllCommentsForAPostBlock)(NSMutableArray *comments,NSError *error);

@interface PosterousClient : NSObject 
{
	NSString *_username;
	NSString *_apitoken;
	NSString *_password; 
}

@property (nonatomic, retain) NSString *_username;
@property (nonatomic, retain) NSString *_apitoken;
@property (nonatomic, retain) NSString *_password; 

-(PosterousClient*) initWithCredentials: (NSString *) username 
							   password: (NSString *) password	
						   apitoken: (NSString *) apitoken; 

//Sites methods
-(void)GetAUsersSites:(PosterousRequest *) requestObject completionBlock:(GetAUsersSitesCompletionBlock)completion;
-(void)GetASingleSite:(PosterousRequest *) requestObject completionBlock:(GetASingleSiteCompletionBlock)completion;
-(void)GetAUsersPrimarySite:(PosterousRequest *) requestObject completionBlock:(GetAUsersPrimarySiteCompletionBlock)completion;

-(void)CreateASite:(PosterousRequest *) requestObject;
-(void)DeleteASite:(PosterousRequest *) requestObject;
-(void)GetASitesSubcribers:(PosterousRequest *) requestObject;
-(void)SubscribeToASite:(PosterousRequest *) requestObject;
-(void)UnsubscribeToASite:(PosterousRequest *) requestObject;

//Users method
-(void)GetAUser:(PosterousRequest *) requestObject completionBlock: (GetAUserCompletionBlock)completion;
-(void)GetAUsersSubscribedSites:(PosterousRequest *) requestObject;

//Posts methods
-(void)GetPublicPostsFromPrimarySite:(PosterousRequest *) requestObject;
-(void)GetPublicPostsFromSiteByHostname:(PosterousRequest *) requestObject;
-(void)GetPublicPostsFromASiteOrID:(PosterousRequest *) requestObject;
-(void)GetPublicPostsFromAnotherUser:(PosterousRequest *) requestObject;
-(void)GetAllPostsForASite:(PosterousRequest *) requestObject;
-(void)GetASinglePost:(PosterousRequest *) requestObject;
-(void)CreateAPost:(PosterousRequest *) requestObject;
-(void)UpdateAPost:(PosterousRequest *) requestObject;
-(void)DeleteAPost:(PosterousRequest *) requestObject;

//Pages methods
-(void)GetAllPages:(PosterousRequest *) requestObject completionBlock: (GetAllPagesCompletionBlock)completion;
-(void)GetASinglePage:(PosterousRequest *) requestObject;
-(void)CreateAPage:(PosterousRequest *) requestObject;
-(void)UpdateAPage:(PosterousRequest *) requestObject;
-(void)DeleteAPage:(PosterousRequest *) requestObject;

//Comments methods
-(void)GetAllCommentsForAPost:(PosterousRequest *) requestObject completionBlock: (GetAllCommentsForAPostBlock)completion;
-(void)CreateAComment:(PosterousRequest *) requestObject;
-(void)DeleteAComment:(PosterousRequest *) requestObject;

//Theme methods
-(void)GetASitesTheme:(PosterousRequest *) requestObject;

//Twitter methods
-(void)UploadPhoto:(PosterousRequest *) requestObject;

//Post.ly
-(void)GetPostByShortCode:(PosterousRequest *) requestObject;
 
@end
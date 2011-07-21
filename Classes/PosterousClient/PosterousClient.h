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
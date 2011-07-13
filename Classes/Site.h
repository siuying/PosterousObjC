//
//  Site.h
//  PosterousObjectiveC
//
//  Created by Joshua Grenon on 8/7/10.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Site : NSObject {

	NSString *name;
	NSString *is_private;
	NSString *full_hostname;
	NSString *posts_count; 
	NSString *_id; 
	NSString *comment_permission; 
	NSString *posts_url; 
	
	/*	 
	 [{
	 "name"              : "twoism's posterous",
	 "is_private"        : false,
	 "full_hostname"     : "twoism.posterous.com",
	 "posts_count"       : 224,
	 "id"                : 1752789,
	 "comment_permission": 2,
	 "posts_url"         : "/api/2/users/637118/sites/1752789/posts"
	 }]	 
	 */
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *is_private;
@property (nonatomic, retain) NSString *full_hostname;
@property (nonatomic, retain) NSString *posts_count; 
@property (nonatomic, retain) NSString *_id; 
@property (nonatomic, retain) NSString *comment_permission; 
@property (nonatomic, retain) NSString *posts_url; 

@end

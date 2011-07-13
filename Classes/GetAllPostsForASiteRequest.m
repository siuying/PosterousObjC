//
//  GetAllPostsForASiteRequest.m
//  PosterousObjectiveC
//
//  Created by Joshua Grenon on 11/28/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import "GetAllPostsForASiteRequest.h"
#import "CJSONDeserializer.h"
#import "Post.h"

@implementation GetAllPostsForASiteRequest

@synthesize delegate1;

-(void)requestFinished
{
	NSData *responseData = [self responseData];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]; 
	NSLog(@"raw data: %@",responseString);
	
	PosterousResponse *response = [[PosterousResponse alloc] init];
	
	NSError *error1 = nil;
	CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
	
	NSArray *resultsDictionary = [jsonDeserializer deserializeAsArray:responseData error:&error1];
	
	if ([resultsDictionary count] > 0) 
	{
		for (int x = 0; x < resultsDictionary.count; x++) {
			
			NSDictionary* node =  [resultsDictionary objectAtIndex:x];
			
			Post *post = [Post alloc];
			post.body_full = [node objectForKey:@"body_full"];
			post.display_date = [node objectForKey:@"display_date"];
			post.full_url = [node objectForKey:@"full_url"];
			post._id = [[node objectForKey:@"id"] stringValue];
			post.is_private = [node objectForKey:@"is_private"];
			//post.mediaArray = [node objectForKey:@"full_url"];
			post.site_id = [node objectForKey:@"site_id"];
			post.slug = [node objectForKey:@"slug"];
			//post.tags = [node objectForKey:@"is_private"];
			post.title = [node objectForKey:@"title"];
			[response.posts addObject:post];			
		} 	
	}
	
	[delegate1 setGetAllPostsForASiteRequestResponseData:response];
}


@end

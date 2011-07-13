//
//  GetAllPostsForASiteRequest.h
//  PosterousObjectiveC
//
//  Created by Joshua Grenon on 11/28/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "PosterousResponse.h"

@protocol GetAllPostsForASiteRequestDelegate;

@interface GetAllPostsForASiteRequest : ASIHTTPRequest 
{
	id <GetAllPostsForASiteRequestDelegate> delegate1;
}

@property (nonatomic, retain) id <GetAllPostsForASiteRequestDelegate> delegate1;

@end

@protocol GetAllPostsForASiteRequestDelegate

-(void)setGetAllPostsForASiteRequestResponseData:(PosterousResponse *)returnedData;

@end

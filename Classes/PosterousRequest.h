//
//  PosterousRequest.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PosterousRequest : NSObject {
	NSString *_id;
	NSString *hostname;
	NSString *primary;
}

@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *hostname;
@property (nonatomic, retain) NSString *primary;

@end

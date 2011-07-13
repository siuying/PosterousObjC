//
//  User.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 11/28/10.
//  Copyright 2010 MotionMobs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {

	NSString *last_activity;
	NSString *nickname;
	NSString *lastname;
	NSString *_id;
	NSString *profile_pic;
	NSString *firstname;
}

@property (nonatomic, retain) NSString *last_activity;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *profile_pic;
@property (nonatomic, retain) NSString *firstname;

@end

//
//  Preferences.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 7/12/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Preferences : NSObject {
    
}

+(NSString*)getEmail;
+(NSString*)getPassword;
+(NSString*)getAPIToken;

@end
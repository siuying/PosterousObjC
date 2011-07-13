//
//  Preferences.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 7/12/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

+(NSString*)getEmail
{
    NSMutableDictionary *credentials = [[NSUserDefaults standardUserDefaults] objectForKey:@"credentials"];
    return [credentials objectForKey:@"email"];
}

+(NSString*)getPassword
{
    NSMutableDictionary *credentials = [[NSUserDefaults standardUserDefaults] objectForKey:@"credentials"];
    return [credentials objectForKey:@"password"];
}

+(NSString*)getAPIToken
{
    NSMutableDictionary *credentials = [[NSUserDefaults standardUserDefaults] objectForKey:@"credentials"];
    return [credentials objectForKey:@"apitoken"];
}

@end
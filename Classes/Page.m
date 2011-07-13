//
//  Page.m
//  PosterousObjC
//
//  Created by Joshua Grenon on 6/11/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

#import "Page.h"


@implementation Page

@synthesize slug;
@synthesize full_url;
@synthesize title;
@synthesize link_id;
@synthesize body;
@synthesize link;
@synthesize _id;
@synthesize url_slug;
@synthesize media;
@synthesize site_id; 

-(id)init:(NSDictionary *)node
{
    self = [super init];
    if (self) 
    {                     
        self.slug = [node objectForKey:@"slug"];
        self.full_url = [node objectForKey:@"full_url"];
        self.title = [node objectForKey:@"title"];
        self.link_id = [node objectForKey:@"link_id"] == nil ? [[node objectForKey:@"link_id"] stringValue] : @"";
        self.body = [node objectForKey:@"body"];
        self.link = [node objectForKey:@"link"];
        self._id =  [[node objectForKey:@"id"] stringValue];
        self.url_slug = [node objectForKey:@"url_slug"];
        self.media = [node objectForKey:@"media"];
        self.site_id = [[node objectForKey:@"site_id"] stringValue];
    }
    return self;
}

-(NSString *)description
{
    NSMutableString *output = [[NSMutableString alloc] init];
    
    [output appendFormat:@"slug: %@\n",self.slug];
    [output appendFormat:@"full_url: %@\n",self.full_url];
    [output appendFormat:@"title: %@\n",self.title];
    [output appendFormat:@"link_id: %@\n",self.link_id];
    [output appendFormat:@"body: %@\n",self.body];
    [output appendFormat:@"link: %@\n",self.link];
    [output appendFormat:@"_id: %@\n",self._id];
    [output appendFormat:@"url_slug: %@\n",self.url_slug];
    [output appendFormat:@"media: %@\n",self.media];
    [output appendFormat:@"site_id: %@\n",self.site_id];
    
    return output;
}

@end

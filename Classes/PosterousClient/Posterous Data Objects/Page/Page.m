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

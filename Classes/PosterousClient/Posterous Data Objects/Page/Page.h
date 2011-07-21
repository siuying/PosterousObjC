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

#import <Foundation/Foundation.h>


@interface Page : NSObject 
{

    // [{"slug":"test","full_url":"http://joshgrenon.posterous.com/pages/test","title":"Test","link_id":3272807,"body":"","link":{"position":0,"title":"Test","url":"http://joshgrenon.posterous.com/pages/test","id":3272807,"parent_id":152017,"site_id":914165},"id":243995,"url_slug":"test","media":[{"audio_files":[]},{"videos":[]},{"images":[]}],"site_id":914165},{"slug":"home","full_url":"http://joshgrenon.posterous.com/pages/home","title":"Home","link_id":null,"body":"","link":null,"id":243996,"url_slug":"home","media":[{"audio_files":[]},{"videos":[]},{"images":[]}],"site_id":914165}]
    
    NSString *slug;
    NSString *full_url;
    NSString *title;
    NSString *link_id;
    NSString *body;
    NSString *link;
    NSString *_id;
    NSString *url_slug;
    NSString *media;
    NSString *site_id;    
}

@property(nonatomic, retain) NSString *slug;
@property(nonatomic, retain) NSString *full_url;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *link_id;
@property(nonatomic, retain) NSString *body;
@property(nonatomic, retain) NSString *link;
@property(nonatomic, retain) NSString *_id;
@property(nonatomic, retain) NSString *url_slug;
@property(nonatomic, retain) NSString *media;
@property(nonatomic, retain) NSString *site_id;  

-init:(NSDictionary *)node;
-(NSString *)description;

@end

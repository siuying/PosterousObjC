//
//  Page.h
//  PosterousObjC
//
//  Created by Joshua Grenon on 6/11/11.
//  Copyright 2011 MotionMobs. All rights reserved.
//

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

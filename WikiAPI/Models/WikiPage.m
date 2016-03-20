//
//  WikiPage.m
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiPage.h"

@implementation WikiPage

#pragma mark - Mapping

/*
 {
 "pageid": 9455408,
 "ns": 6,
 "title": "File:Google1998.png",
 "imagerepository": "local",
 "imageinfo": [
 {
 "url": "https://upload.wikimedia.org/wikipedia/en/b/b7/Google1998.png",
 "descriptionurl": "https://en.wikipedia.org/wiki/File:Google1998.png",
 "descriptionshorturl": "https://en.wikipedia.org/w/index.php?curid=9455408"
 }
 ]
 }
 */

- (void)mapWithDictionary:(NSDictionary *)dictionary {
    self.pageId = [dictionary[@"pageid"] longLongValue];
    self.title = dictionary[@"title"];
    self.image = [[WikiImage alloc] initWithDictionary:[dictionary[@"imageinfo"] firstObject]];
    self.pageImageName = dictionary[@"pageimage"];
}

@end

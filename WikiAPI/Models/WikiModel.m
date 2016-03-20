//
//  WikiModel.m
//  WikiImages
//
//  Created by Alexandre Santos on 20/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiModel.h"

@implementation WikiModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        [self mapWithDictionary:dictionary];
    }
    return self;
}

- (void)mapWithDictionary:(NSDictionary *)dictionary {
    // Override in subclass!
}

@end

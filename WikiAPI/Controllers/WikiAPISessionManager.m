//
//  WikiAPISessionManager.m
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiAPISessionManager.h"

@import AFNetworking;

@implementation WikiAPISessionManager

+ (instancetype)sharedManager {
    static WikiAPISessionManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        _instance = [[WikiAPISessionManager alloc] init];
    });
    
    return _instance;
}

@end

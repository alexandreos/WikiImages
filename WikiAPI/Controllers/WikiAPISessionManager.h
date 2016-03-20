//
//  WikiAPISessionManager.h
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface WikiAPISessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end

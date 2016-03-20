//
//  NSString+WikiExtensions.m
//  WikiImages
//
//  Created by Alexandre Santos on 20/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "NSString+WikiExtensions.h"

@implementation NSString (WikiExtensions)

- (instancetype) stringByNormalizingContents {
    return [self stringByReplacingOccurrencesOfString:@"_" withString:@" "];
}

- (instancetype) stringByDenormalizingContents {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

@end

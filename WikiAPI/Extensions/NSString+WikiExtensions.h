//
//  NSString+WikiExtensions.h
//  WikiImages
//
//  Created by Alexandre Santos on 20/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WikiExtensions)

- (instancetype) stringByNormalizingContents;
- (instancetype) stringByDenormalizingContents;

@end

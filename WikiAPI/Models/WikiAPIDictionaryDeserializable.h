//
//  WikiAPIDictionaryDeserializable.h
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WikiAPIDictionaryDeserializable <NSObject>

- (instancetype) initWithDictionary: (NSDictionary *)dictionary;

- (void)mapWithDictionary:(NSDictionary *)dictionary;

@end

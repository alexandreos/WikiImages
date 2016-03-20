//
//  WikiModel.h
//  WikiImages
//
//  Created by Alexandre Santos on 20/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import <Realm/Realm.h>
#import "WikiAPIDictionaryDeserializable.h"

@interface WikiModel : RLMObject <WikiAPIDictionaryDeserializable>

@end

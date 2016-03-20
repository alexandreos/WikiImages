//
//  WikiImage.h
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiModel.h"

@interface WikiImage : WikiModel

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *urlString;
@property (nonatomic) NSString *descriptionText;

@property (nonatomic, readonly) NSURL *url;

@end

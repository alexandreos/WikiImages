//
//  WikiPage.h
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiModel.h"
#import "WikiImage.h"

@interface WikiPage : WikiModel

@property (nonatomic) long long pageId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *pageImageName;
@property (nonatomic) WikiImage *image;

@end

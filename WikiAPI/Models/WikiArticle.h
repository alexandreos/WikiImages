//
//  WikiArticle.h
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiModel.h"
#import "WikiPage.h"

@interface WikiArticle : WikiModel

@property (nonatomic) NSString *date;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *title;
@property (nonatomic) long long views;
@property (nonatomic) NSInteger rank;

@property (nonatomic) NSArray<WikiPage *> *pages;

// Expanded properties
@property (nonatomic) BOOL isExpanding;
@property (nonatomic) BOOL hasLoaded;

@end

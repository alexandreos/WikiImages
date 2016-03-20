//
//  WikiArticle.m
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiArticle.h"
#import "NSString+WikiExtensions.h"

RLM_ARRAY_TYPE(WikiPage)
@interface WikiArticle ()

@property (nonatomic) RLMArray<WikiPage *><WikiPage> *realmPages;

@end

@implementation WikiArticle
@synthesize pages = _pages;

#pragma mark - Mapping

- (void)mapWithDictionary:(NSDictionary *)dictionary {
    self.name = dictionary[@"article"];
    self.title = [self.name stringByNormalizingContents];
    self.views = [dictionary[@"views"] longLongValue];
    self.rank = [dictionary[@"rank"] integerValue];
}

#pragma mark - Realm

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"isExpanding", @"pages"];
}

#pragma mark - Properties

- (void)setPages:(NSArray<WikiPage *> *)pages {
    if(_pages != pages) {
        _pages = pages;
        
        self.realmPages = (RLMArray<WikiPage *><WikiPage> *)[[RLMArray alloc] initWithObjectClassName:[WikiPage className]];
        [self.realmPages addObjects:pages];
    }
}

- (NSArray<WikiPage *> *)pages {
    if(_pages == nil && self.realmPages) {
        // Load from realm
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.realmPages.count];
        for (WikiPage *page in self.realmPages) {
            [array addObject:page];
        }
        _pages = [array copy];
    }
    return _pages;
}

@end

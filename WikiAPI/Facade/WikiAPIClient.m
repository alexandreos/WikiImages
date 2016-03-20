//
//  WIKIAPIClient.m
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiAPIClient.h"
#import "WikiAPISessionManager.h"
#import "NSDate+WikiAPIExtensions.h"

@import Realm;

@implementation WikiAPIClient

#pragma mark - Stored Data

+ (NSArray<WikiArticle *> * _Nullable)storedArticlesFromYesterday {
    return [self storedArticlesWithDate:[NSDate wk_dateForYesterday]];
}

+ (NSArray<WikiArticle *> * _Nullable)storedArticlesWithDate:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    RLMResults *results = [WikiArticle objectsWhere:@"date == %@", [df stringFromDate:date]];
    
    NSMutableArray *storedArticles;
    if(results.count > 0) {
        storedArticles = [NSMutableArray arrayWithCapacity:results.count];
        for (WikiArticle *article in results) {
            [storedArticles addObject:article];
        }
    }
    
    return [storedArticles copy];
}

+ (BOOL)eraseDatabase:(NSError *__autoreleasing *)error {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSString *databasePath = realm.path;
    return [[NSFileManager defaultManager] removeItemAtPath:databasePath error:error];
}

#pragma mark - API Requests

+ (NSURLSessionDataTask *)topArticlesFromYesterdayWithCompletionHandler:(void (^)(NSArray<WikiArticle *> *articles, NSError *error))completionHandler {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd";
    NSString *yesterdayDateString = [df stringFromDate:[NSDate wk_dateForYesterday]];
    NSString *urlString = [NSString stringWithFormat:@"https://wikimedia.org/api/rest_v1/metrics/pageviews/top/en.wikipedia/all-access/%@", yesterdayDateString];
    return [[WikiAPISessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dicts = [responseObject[@"items"] firstObject][@"articles"];
        NSMutableArray *articles = [NSMutableArray arrayWithCapacity:dicts.count];
        for (NSDictionary *dict in dicts) {
            WikiArticle *article = [[WikiArticle alloc] initWithDictionary:dict];
            article.date = yesterdayDateString;
            [articles addObject:article];
        }
        
        // Persist article data
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObjects:[WikiArticle objectsWhere:@"date == %@", yesterdayDateString]];
            [realm addObjects:articles];
        }];
        
        if(completionHandler) {
            completionHandler([articles copy], nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completionHandler) {
            completionHandler(nil, error);
        }
    }];
}

+ (NSURLSessionDataTask * _Nonnull)expandArticle:(WikiArticle * _Nonnull)article withCompletionHandler:(void (^ _Nonnull)(WikiArticle * _Nullable expandedArticle, NSError * _Nullable error)) completionHandler {

    NSDictionary *params;
    if(article.name) {
        // Unfortunately I was not able to figure out how to get image URL and their correspondent thumbnails in the given time.
        params = @{@"action":@"query", @"format":@"json", @"prop":@"imageinfo",
                   @"iiprop":@"url|extmetadata|mime",@"titles":article.name,@"generator":@"images"};
    }
    article.isExpanding = YES;
    return [[WikiAPISessionManager sharedManager] GET:@"https://en.wikipedia.org/w/api.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // Persist article data
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        NSDictionary *dicts = responseObject[@"query"][@"pages"];
        if(dicts) {
            NSMutableArray *pages = [NSMutableArray array];
            [dicts enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString *mime = [obj[@"imageinfo"] firstObject][@"mime"];
                if([mime containsString:@"jpeg"] || [mime containsString:@"png"]) {
                    WikiPage *page = [[WikiPage alloc] initWithDictionary:obj];
                    [pages addObject:page];
                }
            }];
            article.pages = [pages copy];
        }
        article.isExpanding = NO;
        article.hasLoaded = YES;
        [realm commitWriteTransaction];
        
        if(completionHandler) {
            completionHandler(article, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        article.isExpanding = NO;
        if(completionHandler) {
            completionHandler(nil, error);
        }
    }];
}

@end

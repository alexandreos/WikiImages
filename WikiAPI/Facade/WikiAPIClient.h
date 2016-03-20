//
//  WIKIAPIClient.h
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WikiArticle.h"

@interface WikiAPIClient : NSObject

#pragma mark - Stored Data

/**
 Check for stored articles from yesterday.
 
 @return The array of persisted WikiArticle objects or nil if none.
 */
+ (NSArray<WikiArticle *> * _Nullable)storedArticlesFromYesterday;

/**
 Check for stored articles from the given date.
 
 @param date The date to check for stored articles.
 
 @return The array of persisted WikiArticle objects or nil if none.
 */
+ (NSArray<WikiArticle *> * _Nullable)storedArticlesWithDate:(NSDate * _Nonnull)date;

/**
 Remove all database schemes.
 
 @param error The out error if any.
 
 @return YES in case of success, NO otherwise.
 */
+ (BOOL)eraseDatabase:(NSError * _Nullable * _Nullable) error;

#pragma mark - API Requests

/**
 Fetch the top articles from yesterday
 
 @param completionHandler The completions handler to be called when a response is received.
 
 @return The correspondent session task.
 */
+ (NSURLSessionDataTask * _Nonnull)topArticlesFromYesterdayWithCompletionHandler:(void (^ _Nonnull)(NSArray<WikiArticle *> * _Nullable articles, NSError * _Nullable error)) completionHandler;

/**
 Fetch pages for the given article and expand it.
 
 @param completionHandler The completions handler to be called when a response is received.
 
 @return The correspondent session task.
 */
+ (NSURLSessionDataTask * _Nonnull)expandArticle:(WikiArticle * _Nonnull)article withCompletionHandler:(void (^ _Nonnull)(WikiArticle * _Nullable expandedArticle, NSError * _Nullable error)) completionHandler;

@end

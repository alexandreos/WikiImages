//
//  NSDate+WikiAPIExtensions.m
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "NSDate+WikiAPIExtensions.h"

@implementation NSDate (WikiAPIExtensions)

+ (instancetype)wk_dateForYesterday {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    return [calendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate date] options:0];
}

@end

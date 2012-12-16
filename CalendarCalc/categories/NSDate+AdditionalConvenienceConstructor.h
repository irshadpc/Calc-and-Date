//
//  NSDate+AdditionalConvenienceConstructor.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AdditionalConvenienceConstructor)
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day;

+ (NSDate *)endOfMonthWithYear:(NSInteger)year
                         month:(NSInteger)month;
@end

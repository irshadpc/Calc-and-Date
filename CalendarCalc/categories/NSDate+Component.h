//
//  NSDate+Component.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Component)
- (NSInteger)weekday;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;
@end

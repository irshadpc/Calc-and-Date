//
//  CCDateResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateResult : NSObject {
  @private
    NSDate *_date;
}

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;

- (void)clear;

- (NSDate *)result;
- (void)setResult:(NSDate *)date;

- (void)inputDate:(NSDate *)date;

- (NSString *)displayResult;
@end

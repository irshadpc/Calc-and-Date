//
//  CCCalendarCalc+Date.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCDateCalculator.h"

@interface CCDateCalculator : NSObject {
  @private
    NSDecimalNumber *_numberResult;
    NSDate *_dateResult;
    BOOL _isDateResult;
}

@property (strong, nonatomic) NSArray *excludeWeeks;

- (void)clear;

- (NSDate *)plusWithNumber:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand;

- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand;

- (NSDate *)multiplyWithNumber:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)multiplyWithDate:(NSDate *)rOperand;

- (NSDate *)divideWithNumber:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)divideWithDate:(NSDate *)rOperand;

- (NSDate *)setDateRusult:(NSDate *)result;
- (NSDecimalNumber *)setNumberResult:(NSDecimalNumber *)result;

- (NSDecimalNumber *)reverse;

- (NSDate *)dateResult;
- (NSDecimalNumber *)numberResult;
@end

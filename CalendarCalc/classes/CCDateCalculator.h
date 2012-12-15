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

@property (weak, nonatomic) NSArray *weekStates;

- (void)clear;

- (NSDate *)plusWithNumber:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand;

- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand;

- (NSDate *)equalWithDate:(NSDate *)rOperand;
- (NSDecimalNumber *)equalWithNumber:(NSDecimalNumber *)rOperand;

- (NSDate *)dateResult;
- (NSDecimalNumber *)numberResult;
@end

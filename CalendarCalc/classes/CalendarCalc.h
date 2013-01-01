//
//  CalendarCalc.h
//  CalendarCalc
//
//  Created by 純一 石田 on 12/07/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NumberCalc;
@class DateCalc;

@interface CalendarCalc : NSObject {
@private
    NumberCalc *numberCalc_;
    DateCalc *dateCalc_;

    NSUInteger oldOperator_;
    NSDecimalNumber *numberOperand_;
    NSDecimalNumber *numberResult_;
    NSDate *dateOperand_;
    NSDate *dateResult_;
    NSDecimalNumber *suspendValue_;
    NSArray *resultSet_;

    NSNumberFormatter *plainNumberFormatter_;
    NSNumberFormatter *scientificNumberFormatter_;
    NSDateFormatter *dateFormatter_;

    NSUInteger mode_;
    BOOL isReset_;
    BOOL isAllReset_;
    BOOL isOperatorEnabled_;
}

- (NSArray *)inputNumber:(NSDecimalNumber *)number;
- (NSString *)inputDate:(NSDate *)date;
- (NSArray *)inputAction:(NSUInteger)action;
- (NSArray *)result;
- (void)setWeekStates:(NSArray *)weekStates;
@end

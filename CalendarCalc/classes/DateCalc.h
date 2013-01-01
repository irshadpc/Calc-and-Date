//
//  DateCalc.h
//  CalendarCalc
//
//  Created by 純一 石田 on 12/07/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateCalc : NSObject {
@private
    NSDecimalNumber *numberResult;
    NSDate *dateResult;

    BOOL isDateResult;
}

@property (weak, nonatomic) NSArray *weekStates;

- (NSDate *)equalWithDate:(NSDate *)rOperand;
- (NSDecimalNumber *)equalWithNumber:(NSDecimalNumber *)rOperand;

- (void)clear;

- (NSDate *)dateResult;
- (NSDecimalNumber *)numberResult;

- (NSDate *)plusWithNumber:(NSDecimalNumber *)rOperand;
- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand;

- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand;
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand;
@end

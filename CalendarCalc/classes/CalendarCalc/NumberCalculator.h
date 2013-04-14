//
//  CCCalendarCalc+Number.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NumberCalculator.h"

@interface NumberCalculator : NSObject {
  @private
    NSDecimalNumber *_result;
}

- (void)clear;

- (NSDecimalNumber *)plus:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)minus:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)multiply:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)divide:(NSDecimalNumber *)rOperand;
- (NSDecimalNumber *)reverse;

- (NSDecimalNumber *)setResult:(NSDecimalNumber *)result;
- (NSDecimalNumber *)result;
@end

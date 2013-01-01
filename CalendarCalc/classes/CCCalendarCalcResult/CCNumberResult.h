//
//  CCNumberResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCCalendarCalcResult;

@interface CCNumberResult : NSObject {
  @private
    NSMutableString *_number;
    NSMutableString *_decimal;
    BOOL _isMinus;
    BOOL _isDecimal;
    BOOL _isClear;
}

- (void)clear;

- (NSDecimalNumber *)result;
- (void)setResult:(NSDecimalNumber *)number;

- (void)clearEntry;
- (void)inputNumber:(NSDecimalNumber *)number;
- (void)inputDecimalPoint;
- (void)reverse;

- (NSString *)displayResult;
@end
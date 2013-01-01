//
//  CalendarCalc.m
//  CalendarCalc
//
//  Created by 純一 石田 on 12/07/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalendarCalc.h"
#import "NumberCalc.h"
#import "DateCalc.h"
#import "FormatUtil.h"
#import "NSDecimalNumber+util.h"
#import "NSDate+util.h"

@interface CalendarCalc()
- (void)plus;
- (void)minus;
- (void)multiply;
- (void)divide;
- (NSString *)dateResult:(NSDate *)date;
- (BOOL)isNumberCalc;
- (BOOL)isRangeLimitOver:(NSArray *)resultSet;

- (NSArray *)doOperation:(NSUInteger)operator;
- (NSArray *)doFunction:(NSUInteger)function;

- (BOOL)isOperator:(NSUInteger)operator;
- (BOOL)isFunction:(NSUInteger)function;

- (NSArray *)appendNumber:(NSArray *)lOperand rOperand:(NSDecimalNumber *)rOperand; 

- (NSArray *)numberReverse;
- (NSArray *)deleteChar;
- (void)clear;
- (void)allClear;
- (NSArray *)resultArrayWithNumber:(NSString *)number decimal:(NSString *)decimal;
- (NSArray *)resultArrayWithDecimalNumber:(NSDecimalNumber *)decimalNumber;
- (NSDecimalNumber *)resultNumber:(NSArray *)resultSet;
@end

@implementation CalendarCalc

static NSUInteger DIGITS = 12;

enum {
    EMPTY = 0,
    POINT = 301,
    EQUAL,
    PLUS,
    MINUS,
    MULTI,
    DIVIDE,
    CLEAR,
    PLUS_MINUS,
    DELETE,
    ACTION_END,
};

enum {
    NORMAL_MODE = ACTION_END + 1,
    POINT_MODE,
    ADDING_SUSPEND_MODE,
    MINUS_SUSPEND_MODE,
    MULTIPLY_SUSPEND_MODE,
    DIVIDE_SUSPEND_MODE,
};

//{{{ init
////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        numberCalc_ = [[NumberCalc alloc] init];
        dateCalc_ = [[DateCalc alloc] init];
        plainNumberFormatter_ = [FormatUtil plainNumberFormatter:DIGITS];
        scientificNumberFormatter_ = [FormatUtil scientiricFormatter:DIGITS];
        dateFormatter_ = [FormatUtil dateFormatter];
        [self allClear];
        return self;
    }
    return nil;
}

- (void) dealloc {
    plainNumberFormatter_ = nil;
    scientificNumberFormatter_ = nil;
    dateFormatter_ = nil;
    dateCalc_ = nil;
    numberCalc_ = nil;
}
//}}}

//{{{ public methods

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)inputNumber:(NSDecimalNumber *)number {
    if (isAllReset_) {
        isAllReset_ = NO;
        [self allClear];
    }

    if (isReset_) {
        isReset_ = NO;
        resultSet_ = [self resultArrayWithNumber:nil decimal:nil];
        numberOperand_ = nil;
    }
    dateOperand_ = nil;
    isOperatorEnabled_ = YES;

    NSArray *appended = [self appendNumber:resultSet_
                                  rOperand:number];
    if (![self isRangeLimitOver:appended]) {
        numberOperand_ = [self resultNumber:appended];
        resultSet_ = appended;
    }
    return [NSArray arrayWithObjects:[resultSet_ objectAtIndex:0],
                                     [resultSet_ objectAtIndex:1],
                                     nil];
}

////////////////////////////////////////////////////////////////////////////////
- (NSString *)inputDate:(NSDate *)date {
    if (isAllReset_) {
        isAllReset_ = NO;
        [self allClear];
    }

    if (mode_ == POINT_MODE) {
        mode_ = NORMAL_MODE;
    }

    if (isReset_) {
        isReset_ = NO;
        resultSet_ = [self resultArrayWithNumber:nil decimal:nil];
        dateOperand_ = nil;
    }

    dateOperand_ = date;
    resultSet_ = [self resultArrayWithNumber:nil decimal:nil];
    numberOperand_ = nil;
    isOperatorEnabled_ = YES;

    return [dateFormatter_ stringFromDate:dateOperand_];
}

- (void)setWeekStates:(NSArray *)weekStates {
    [dateCalc_ setWeekStates:weekStates];
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)inputAction:(NSUInteger)action {
    if (mode_ == POINT_MODE) {
        mode_ = NORMAL_MODE;
    }

    if ([self isOperator:action]) {
        return [self doOperation:action];
    } else if ([self isFunction:action]) {
        return [self doFunction:action];
    } else {
        abort();
    }
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)result {
    if (numberResult_) {
        return [self resultArrayWithDecimalNumber:numberResult_];
    } else if (dateResult_) {
        return [NSArray arrayWithObject:[self dateResult:dateResult_]];
    } else {
        return [self resultArrayWithDecimalNumber:[NSDecimalNumber zero]];
    }
}

//}}}

//{{{ calc
////////////////////////////////////////////////////////////////////////////////
- (void)plus {
    if ([self isNumberCalc]) {
        [numberCalc_ equal:numberResult_];
        numberResult_ = [numberCalc_ plus:numberOperand_];
        dateResult_ = nil;
    } else {
        [dateCalc_ equalWithDate:dateResult_];
        [dateCalc_ equalWithNumber:numberResult_];

        [dateCalc_ plusWithDate:dateOperand_];
        [dateCalc_ plusWithNumber:numberOperand_];
        if ([dateCalc_ numberResult]) {
            numberResult_ = [dateCalc_ numberResult];
            dateResult_ = nil;
        } else {
            dateResult_ = [dateCalc_ dateResult];
            numberResult_ = nil;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
- (void)minus {
    if ([self isNumberCalc]) {
        [numberCalc_ equal:numberResult_];
        numberResult_ = [numberCalc_ minus:numberOperand_];
        dateResult_ = nil;
    } else {
        [dateCalc_ equalWithDate:dateResult_];
        [dateCalc_ equalWithNumber:numberResult_];

        [dateCalc_ minusWithDate:dateOperand_];
        [dateCalc_ minusWithNumber:numberOperand_];
        if ([dateCalc_ numberResult]) {
            numberResult_ = [dateCalc_ numberResult];
            dateResult_ = nil;
        } else {
            dateResult_ = [dateCalc_ dateResult];
            numberResult_ = nil;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
- (void)multiply {
    if (!numberOperand_ && numberResult_ && dateOperand_ && !dateResult_ && mode_ == NORMAL_MODE) {
        mode_ = MULTIPLY_SUSPEND_MODE;
        suspendValue_ = numberResult_;
        dateResult_ = dateOperand_;
        numberResult_ = nil;
        return;
    }
    [numberCalc_ equal:numberResult_];
    numberResult_ = [numberCalc_ multiply:numberOperand_];
    dateResult_ = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (void)divide {
    if (!numberOperand_ && numberResult_ && dateOperand_ && !dateResult_ && mode_ == NORMAL_MODE) {
        mode_ = DIVIDE_SUSPEND_MODE;
        suspendValue_ = numberResult_;
        dateResult_ = dateOperand_;
        numberResult_ = nil;
        return;
    }
    [numberCalc_ equal:numberResult_];
    numberResult_ = [numberCalc_ divide:numberOperand_];
    dateResult_ = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (BOOL)isNumberCalc {
    return !dateResult_ && numberOperand_;
}
            
////////////////////////////////////////////////////////////////////////////////
- (BOOL)isRangeLimitOver:(NSArray *)resultSet {                
    NSString *number = [resultSet objectAtIndex:0];
    NSString *decimal = [resultSet objectAtIndex:1];
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];

    return [number length] + [decimal length] > DIGITS;
}

////////////////////////////////////////////////////////////////////////////////
- (NSString *)dateResult:(NSDate *)date {
    if (![FormatUtil isDate:[dateFormatter_ stringFromDate:date]]) {
        return [plainNumberFormatter_ stringFromNumber:[NSDecimalNumber zero]];
    }
    return [dateFormatter_ stringFromDate:date];
}
//}}}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)doOperation:(NSUInteger)operator {
    if (!isOperatorEnabled_ && operator != EQUAL) {
        oldOperator_ = operator;
        isAllReset_ = NO;
        return [self result];
    } 

    if (oldOperator_ == EMPTY) {
        numberResult_ = numberOperand_;
        dateResult_ = dateOperand_;
    } else if (oldOperator_ == PLUS) {
        [self plus];
    } else if (oldOperator_ == MINUS) {
        [self minus];
    } else if (oldOperator_ == MULTI) {
        [self multiply];
    } else if (oldOperator_ == DIVIDE) {
        [self divide];
    } else {
        abort();
    }

    if (mode_ == ADDING_SUSPEND_MODE && numberResult_) {
        numberOperand_ = numberResult_;
        numberResult_ = suspendValue_;
        suspendValue_ = nil;
        [self plus];
        mode_ = NORMAL_MODE;
    } else if (mode_ == MINUS_SUSPEND_MODE && numberResult_) {
        numberOperand_ = numberResult_;
        numberResult_ = suspendValue_;
        suspendValue_ = nil;
        [self minus];
        mode_ = NORMAL_MODE;
    } else if (mode_ == MULTIPLY_SUSPEND_MODE && numberResult_) {
        numberOperand_ = numberResult_;
        numberResult_ = suspendValue_;
        suspendValue_ = nil;
        [self multiply];
        mode_ = NORMAL_MODE;
    } else if (mode_ == DIVIDE_SUSPEND_MODE && numberResult_) {
        numberOperand_ = numberResult_;
        numberResult_ = suspendValue_;
        suspendValue_ = nil;
        [self divide];
        mode_ = NORMAL_MODE;
    }

    if (operator == EQUAL) {
        isAllReset_ = YES;
        operator = oldOperator_;
        [numberCalc_ clear];
        [dateCalc_ clear];
        dateOperand_ = nil;
    } else {
        isAllReset_ = NO;
    }

    isReset_ = YES;
    isOperatorEnabled_ = NO;
    oldOperator_ = operator;
    return [self result];
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)doFunction:(NSUInteger)function {
    mode_ = NORMAL_MODE;
    if (function == POINT) {
        if (isAllReset_) {
            [self allClear];
        }
        mode_ = POINT_MODE;
    } else if (function == PLUS_MINUS) {
        return [self numberReverse];
    } else if (function == DELETE) {
        return [self deleteChar];
    } else if (function == CLEAR) {
        [self clear];
        return [self resultArrayWithNumber:[[NSDecimalNumber zero] stringValue]
                                   decimal:nil];
    }
    return nil;
}

////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOperator:(NSUInteger)operator {
    switch (operator) {
    case PLUS:
    case MINUS:
    case MULTI:
    case DIVIDE:
    case EQUAL:
        return YES;
    default:
        return NO;
    }
}

////////////////////////////////////////////////////////////////////////////////
- (BOOL)isFunction:(NSUInteger)function {
    switch (function) {
    case POINT:
    case PLUS_MINUS:
    case DELETE:
    case CLEAR:
        return YES;
    default:
        return NO;
    }
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)appendNumber:(NSArray *)lOperand rOperand:(NSDecimalNumber *)rOperand {

    NSDecimalNumber *lOperandNumber = [NSDecimalNumber decimalNumberWithNumber:[plainNumberFormatter_ numberFromString:[lOperand objectAtIndex:0]]];
    NSString *lOperandString = [plainNumberFormatter_ stringFromNumber:[NSDecimalNumber zero]];
    if (![NSDecimalNumber isNan:lOperandNumber]) {
        lOperandString = [plainNumberFormatter_ stringFromNumber:lOperandNumber];
    }
    if ([[lOperand objectAtIndex:0] hasPrefix:@"-"]) {
        lOperandString = [@"-" stringByAppendingString:[lOperandString stringByReplacingOccurrencesOfString:@"-"
                                                                                                 withString:@""]];
    }

    NSString *decimal = [lOperand objectAtIndex:1];
    if (!lOperandString || [lOperandString length] == 0) {
       lOperandString = [plainNumberFormatter_ stringFromNumber:[NSDecimalNumber zero]]; 
    }
    NSString *rOperandString = [plainNumberFormatter_ stringFromNumber:[NSDecimalNumber round:rOperand
                                                                                        scale:DIGITS - 2
                                                                                 roundingMode:NSRoundDown]];

    if (mode_ == POINT_MODE || (decimal && [decimal length] > 0)) {
        mode_ = NORMAL_MODE;
        NSInteger maxDecimalLength = DIGITS - [lOperandString stringByReplacingOccurrencesOfString:@"-"
                                                                                        withString:@""].length - 1;
        decimal = [decimal substringToIndex:[decimal length] < maxDecimalLength ? [decimal length] : maxDecimalLength];
        return [self resultArrayWithNumber:[plainNumberFormatter_ stringFromNumber:[plainNumberFormatter_ numberFromString:lOperandString]]
                                   decimal:[decimal stringByAppendingString:rOperandString]];
    }
    return [self resultArrayWithNumber:[plainNumberFormatter_ stringFromNumber:[plainNumberFormatter_ numberFromString:[lOperandString stringByAppendingString:rOperandString]]]
                               decimal:decimal];
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)numberReverse {
    if (!numberOperand_ && dateOperand_) {
        return nil;
    }

    if (isReset_ && isAllReset_) {
        numberResult_ = [NSDecimalNumber negate:numberResult_];
        NSArray *numberSet = [[plainNumberFormatter_ stringFromNumber:numberResult_]
                              componentsSeparatedByString:[[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator]];
        if ([numberSet count] == 1) {
            resultSet_ = [self resultArrayWithNumber:[numberSet objectAtIndex:0]
                                             decimal:nil];
        } else if ([numberSet count] == 2) {
            resultSet_ = [self resultArrayWithNumber:[numberSet objectAtIndex:0]
                                             decimal:[numberSet objectAtIndex:1]];
        }
        return resultSet_;
    } else if (isReset_) {
        [self inputNumber:[NSDecimalNumber zero]];
        [self numberReverse];
        [self numberReverse];
    }
    NSString *number = [resultSet_ objectAtIndex:0];
    if ([number hasPrefix:@"-"]) {
        number = [number stringByReplacingOccurrencesOfString:@"-"
                                                   withString:@""];
    } else {
        number = [@"-" stringByAppendingString:number];
    }
    resultSet_ = [self resultArrayWithNumber:number 
                                     decimal:[resultSet_ objectAtIndex:1]];
    numberOperand_ = [self resultNumber:resultSet_];
    return resultSet_;
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)deleteChar {
    dateOperand_ = nil;

    NSString *decimal = @"";
    if ([resultSet_ count] == 2) {
        decimal = [resultSet_ objectAtIndex:1];
    }
    if ([NSDecimalNumber isNan:numberOperand_] || isReset_) {
        numberOperand_ = [NSDecimalNumber zero];
        resultSet_ = [self resultArrayWithNumber:nil decimal:nil];
        return resultSet_;
    } else if (decimal && [decimal length] > 0) {
        NSString *deleted = [decimal substringToIndex:[decimal length] - 1];
        resultSet_ = [self resultArrayWithNumber:[resultSet_ objectAtIndex:0]
                                         decimal:deleted];
        numberOperand_ = [self resultNumber:resultSet_];
        return resultSet_;
    }
    NSString *numberString = [plainNumberFormatter_ stringFromNumber:numberOperand_];
    
    if ([numberString length] <= 1) {
        numberString = [plainNumberFormatter_ stringFromNumber:[NSDecimalNumber zero]];
    } else {
        numberString = [numberString substringToIndex:[numberString length] - 1];
    }
    numberOperand_ = [NSDecimalNumber decimalNumberWithNumber:[plainNumberFormatter_ numberFromString:numberString]];
    if ([NSDecimalNumber isNan:numberOperand_]) {
        numberOperand_ = [NSDecimalNumber zero];
    }
    resultSet_ = [self resultArrayWithNumber:[plainNumberFormatter_ stringFromNumber:numberOperand_]
                                                                             decimal:nil];
    return resultSet_;
}

////////////////////////////////////////////////////////////////////////////////
- (void)clear {
    if (isReset_) {
        [self allClear];
    } else {
        resultSet_ = [self resultArrayWithNumber:nil decimal:nil];
        numberOperand_ = nil;
        dateOperand_ = nil;
        isReset_ = YES;
    }
}

////////////////////////////////////////////////////////////////////////////////
- (void)allClear {
    mode_ = NORMAL_MODE;
    resultSet_ = [self resultArrayWithNumber:nil decimal:nil];
    oldOperator_ = EMPTY;
    numberOperand_ = nil;
    dateOperand_ = nil;
    numberResult_ = nil;
    dateResult_ = nil;
    suspendValue_ = nil;
    isReset_ = NO;
    isAllReset_ = NO;
    isOperatorEnabled_ = NO;
    [numberCalc_ clear];
    [dateCalc_ clear];
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)resultArrayWithNumber:(NSString *)number decimal:(NSString *)decimal {
    NSString *resultNumber = number;
    if (!resultNumber) {
        resultNumber = [plainNumberFormatter_ stringFromNumber:[NSDecimalNumber zero]];
    }

    NSString *resultDecimal = decimal;
    if (!resultDecimal) {
        resultDecimal = @"";
    }
    
    return [NSArray arrayWithObjects:resultNumber,
                                     resultDecimal,
                                     nil];
}

////////////////////////////////////////////////////////////////////////////////
- (NSArray *)resultArrayWithDecimalNumber:(NSDecimalNumber *)decimalNumber {
   if (!decimalNumber) {
       return [self resultArrayWithNumber:nil decimal:nil];
   }
   NSArray *numberSet = [[plainNumberFormatter_ stringFromNumber:decimalNumber]
                         componentsSeparatedByString:[[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator]];
   NSString *number = [numberSet objectAtIndex:0];
   NSString *decimal = @"";
   if ([numberSet count] == 2) {
       decimal = [numberSet objectAtIndex:1];
   }
   return [self resultArrayWithNumber:number decimal:decimal];

}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)resultNumber:(NSArray *)resultSet {
    if (!resultSet) {
        return [NSDecimalNumber zero];
    } 
    if ([resultSet count] == 1) {
        return [NSDecimalNumber decimalNumberWithNumber:[plainNumberFormatter_ numberFromString:[resultSet objectAtIndex:0]]];
    }
    return [NSDecimalNumber decimalNumberWithNumber:
            [plainNumberFormatter_ numberFromString:[NSString stringWithFormat:
                                                     @"%@%@%@",
                                                     [resultSet objectAtIndex:0],
                                                     [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator],
                                                     [resultSet objectAtIndex:1]]]];
}
@end

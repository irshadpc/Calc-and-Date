//
//  DateCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "DateCalc.h"
#import "DateCalcProcessor.h"
#import "DateCalcResult.h"
#import "Function.h"
#import "NSString+Calculator.h"

@interface DateCalc ()
@property(nonatomic) Function currentFunction;
@property(strong, nonatomic) DateCalcProcessor *processor;
@property(strong, nonatomic) DateCalcResult *result;

- (CalcValue *)inputWithKeyCode:(NSInteger)keycode;
- (CalcValue *)inputWithFunction:(Function)function;
@end

@implementation DateCalc
- (instancetype)init
{
    if ((self = [super init])) {
        _processor = [[DateCalcProcessor alloc] init];
        _result = [[DateCalcResult alloc] init];
    }
    return self;
}

- (CalcValue *)inputWithInteger:(NSInteger)integer
{
    if (integer < FunctionDecimal) {
        return [self inputWithKeyCode:integer];
    } else {
        return [self inputWithFunction:integer];
    }
}

- (CalcValue *)inputWithDate:(NSDate *)date
{
    return [self.result inputDate:date];
}


#pragma mark - Private

- (CalcValue *)inputWithKeyCode:(NSInteger)keycode
{
    return [self.result inputNumberString:[NSString stringWithKeyCode:keycode]];
}

- (CalcValue *)inputWithFunction:(Function)function
{
    CalcValue *result = [self.processor calculateWithFunction:self.currentFunction
                                                      operand:[self.result calcValue]];
    [self setCurrentFunction:function];
    [self setResult:[[DateCalcResult alloc] init]];
   
    return result;
}
@end

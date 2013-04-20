//
//  CalcValueFormatter.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/17.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalcValue;

@interface CalcValueFormatter : NSObject
+ (NSString *)displayNumberWithCalcValue:(CalcValue *)calcValue;
+ (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue;
@end

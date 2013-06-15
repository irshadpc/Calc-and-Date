//
//  CalcValueFormatter.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/17.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalcValue;
@class CalcController;

@interface CalcControllerFormatter : NSObject
- (instancetype)initWithCalcController:(CalcController *)calcController;
- (NSString *)displayValue;
- (NSString *)displayIndicatorValue;
- (NSString *)displayClearTitle;
@end

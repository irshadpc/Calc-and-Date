//
//  DateCalcProcessor.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"

@class CalcValue;

@interface DateCalcProcessor : NSObject
@property(strong, nonatomic) NSArray *excludeWeeks;
@property(nonatomic, getter=isIncludeStartDay) BOOL includeStartDay;

- (CalcValue *)calculateWithFunction:(Function)function
                            lOperand:(CalcValue *)lOperand
                            rOperand:(CalcValue *)rOperand;
@end

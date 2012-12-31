//
//  NSDate+Calc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calc)
- (NSDate *)addingByYear:(NSInteger)year;
- (NSDate *)addingByDay:(NSInteger)day;
- (NSInteger)dayIntervalWithDate:(NSDate *)date;
@end

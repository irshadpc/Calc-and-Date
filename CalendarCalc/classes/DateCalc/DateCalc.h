//
//  DateCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalcValue;

@interface DateCalc : NSObject
- (CalcValue *)input:(NSInteger)integer;
- (CalcValue *)inputWithDate:(NSDate *)date;
@end

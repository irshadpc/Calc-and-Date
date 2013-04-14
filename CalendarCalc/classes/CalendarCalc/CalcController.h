//
//  CalcController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcController : NSObject
- (NSString *)inputInteger:(NSInteger)integer;
- (NSString *)inputDate:(NSDate *)date;
@end

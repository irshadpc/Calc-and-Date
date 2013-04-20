//
//  CCViewController+UnitTest.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/25.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController.h"

@interface CalendarCalcViewController (UnitTest)
- (void)pressCalcKey:(UIButton *)sender;
- (void)inputOutDate:(NSDate *)date;
- (NSString *)resultText;
@end

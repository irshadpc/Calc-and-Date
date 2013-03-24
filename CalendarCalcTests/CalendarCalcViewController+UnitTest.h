//
//  CCViewController+UnitTest.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/25.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController.h"

@interface CalendarCalcViewController (UnitTest)
- (void)pressNumberButton:(UIButton *)sender;
- (void)pressFunctionButton:(UIButton *)sender;
- (void)inputOutDate:(NSDate *)date;
- (NSString *)resultText;
@end

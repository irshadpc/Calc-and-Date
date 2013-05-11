//
//  CCViewController+UnitTest.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/25.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController+UnitTest.h"

@implementation CalendarCalcViewController_iPhone (UnitTest)
- (void)pressCalcKey:(UIButton *)sender
{
    [self performSelector:@selector(onCalcKey:) withObject:sender];
}

- (void)inputOutDate:(NSDate *)date
{
    [self performSelector:@selector(didSelectDate:) withObject:date];
}

- (NSString *)resultText
{
    return [[self valueForKey:@"display"] text];
}
@end

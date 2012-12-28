//
//  CCViewController+UnitTest.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/25.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCViewController+UnitTest.h"

@implementation CCViewController (UnitTest)
- (void)pressNumberButton:(UIButton *)sender
{
    [self performSelector:@selector(onNumber:) withObject:sender];
}

- (void)pressFunctionButton:(UIButton *)sender
{
    [self performSelector:@selector(onFunction:) withObject:sender];
}

- (void)inputOutDate:(NSDate *)date
{
    [self performSelector:@selector(didSelectDate:) withObject:date];
}

- (NSString *)resultText
{
    return [[self performSelector:@selector(display)] text];
}
@end

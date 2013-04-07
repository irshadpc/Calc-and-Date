//
//  CCCalendarCalcViewController_iPhone.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPhone.h"
#import "CalendarCalcViewController.h"
#import "CalendarViewController+Week.h"
#import "ViewSheet.h"
#import "NSDate+Component.h"
#import "NSString+Date.h"

@interface CalendarCalcViewController_iPhone ()
@property(weak, nonatomic) IBOutlet UIButton *dateButton;

- (IBAction)onDate:(UIButton *)sender;
@end

@implementation CalendarCalcViewController_iPhone
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDate *date = [NSDate date];
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]]
                     forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [self setDateButton:nil];
    [super viewDidUnload];
}


#pragma mark - Override

- (void)configureView
{
    [super configureView];
    NSDate *date = self.calendarViewController.date;
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]]
                     forState:UIControlStateNormal];
}


#pragma mark - Action

- (IBAction)onDate:(UIButton *)sender
{
    [self showCalendarView];
}
@end
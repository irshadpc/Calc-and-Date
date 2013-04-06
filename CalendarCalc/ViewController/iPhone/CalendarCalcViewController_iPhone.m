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

@interface CalendarCalcViewController_iPhone ()<CalendarViewControllerDelegate>
@property(weak, nonatomic) IBOutlet UIButton *dateButton;
@property(strong, nonatomic) ViewSheet *currentViewSheet;

- (IBAction)onDate:(UIButton *)sender;
@end

@implementation CalendarCalcViewController_iPhone
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.calendarViewController setToolbarDelegate:self];
    [self.calendarViewController setShowWeekView:YES];
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

- (void)showEventView:(UIButton *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[EventViewController alloc] init];
        [self.eventViewController setDelegate:self];
    }

    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
    self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.eventViewController];
    [self.currentViewSheet showViewSheetAnimated:YES];
}

- (void)configureView
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
    self.display.text = [self.calendarCalcFormatter displayResult];
    self.indicator.text = [self.calendarCalcFormatter displayIndicator];
    [self.clearButton setTitle:[self.calendarCalcFormatter displayClearButtonTitle]
                      forState:UIControlStateNormal];

    NSDate *date = self.calendarViewController.date;
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]]
                     forState:UIControlStateNormal];
}


#pragma mark - Action

- (IBAction)onDate:(UIButton *)sender
{
    if (!self.calendarViewController) {
        self.calendarViewController = [[CalendarViewController alloc] init];
    }

    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
    self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.calendarViewController];
    [self.currentViewSheet showViewSheetAnimated:YES];
}


- (void)calendarViewControllerDidCancel:(CalendarViewController *)viewController
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
}

- (void)calendarViewControllerShouldShowEvent:(CalendarViewController *)viewController
{
    [self showEventView:nil];
}
@end
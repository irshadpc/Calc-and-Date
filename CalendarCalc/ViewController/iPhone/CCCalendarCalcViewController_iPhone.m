//
//  CCCalendarCalcViewController_iPhone.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcViewController_iPhone.h"
#import "CCCalendarCalcViewController.h"
#import "CCViewSheet.h"
#import "CCAppDelegate+Setting.h"
#import "NSDate+Component.h"
#import "NSString+Date.h"

@interface CCCalendarCalcViewController_iPhone () <CCViewSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

- (IBAction)onDate:(UIButton *)sender;
- (UIBarButtonItem *)eventButton;
- (UIBarButtonItem *)eventDoneButton;
@end

@implementation CCCalendarCalcViewController_iPhone

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

#pragma mark - IBAction

- (IBAction)onDate:(UIButton *)sender
{
    if (!self.calendarViewController) {
        self.calendarViewController = [[CCCalendarViewController alloc] init];
    }

    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }

    [self.calendarViewController setDynamicCalendar:
     [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption]];
    _currentViewSheet = [[CCViewSheet alloc] initWithContentViewController:self.calendarViewController];
    _currentViewSheet.delegate = self;
    [_currentViewSheet setRightButton:[self eventButton]];
    [_currentViewSheet showInView:self.view animated:YES];
}


#pragma mark - Private

- (void)onEventButton:(UIBarButtonItem *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[CCEventViewController alloc] init];
    }

    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }

    _currentViewSheet = [[CCViewSheet alloc] initWithContentViewController:self.eventViewController];
    _currentViewSheet.delegate = self;
    [_currentViewSheet setRightButton:[self eventDoneButton]];
    [_currentViewSheet showInView:self.view animated:YES];
}

- (UIBarButtonItem *)eventButton
{
    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"EVENT", nil)
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(onEventButton:)];
}

- (UIBarButtonItem *)eventDoneButton
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(onEventDone:)];
}

- (void)configureView
{
    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }
    
    self.display.text = [self.calendarCalcFormatter displayResult];
    self.indicator.text = [self.calendarCalcFormatter displayIndicator];
    [self.clearButton setTitle:[self.calendarCalcFormatter displayClearButtonTitle]
                      forState:UIControlStateNormal];

    NSDate *date = self.calendarViewController.date;
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]]
                     forState:UIControlStateNormal];
}


#pragma mark - CCViewSheet

- (void)viewSheetClickedCancelButton:(CCViewSheet *)viewSheet
{
    [self configureView];
}

@end

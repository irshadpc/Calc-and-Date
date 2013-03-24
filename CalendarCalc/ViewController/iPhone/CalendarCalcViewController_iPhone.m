//
//  CCCalendarCalcViewController_iPhone.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPhone.h"
#import "CalendarCalcViewController.h"
#import "ViewSheet.h"
#import "NSDate+Component.h"
#import "NSString+Date.h"

@interface CalendarCalcViewController_iPhone () <ViewSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

- (IBAction)onDate:(UIButton *)sender;
- (UIBarButtonItem *)eventButton;
- (UIBarButtonItem *)eventDoneButton;
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

- (void)showEventView:(UIButton *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[EventViewController alloc] init];
    }

    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }

    _currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.eventViewController];
    _currentViewSheet.delegate = self;
    [_currentViewSheet setRightButton:[self eventDoneButton]];
    [_currentViewSheet showInView:self.view animated:YES];
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


#pragma mark - IBAction

- (IBAction)onDate:(UIButton *)sender
{
    if (!self.calendarViewController) {
        self.calendarViewController = [[CalendarViewController alloc] init];
    }

    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }

    _currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.calendarViewController];
    _currentViewSheet.delegate = self;
    [_currentViewSheet setRightButton:[self eventButton]];
    [_currentViewSheet showInView:self.view animated:YES];
}


#pragma mark - Private

- (UIBarButtonItem *)eventButton
{
    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"EVENT", nil)
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(showEventView:)];
}

- (UIBarButtonItem *)eventDoneButton
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(onEventDone)];
}


#pragma mark - ViewSheet

- (void)viewSheetClickedCancelButton:(ViewSheet *)viewSheet
{
    [self configureView];
}

@end

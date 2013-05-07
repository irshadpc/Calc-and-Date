//
//  CCCalendarViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarViewController_Common.h"
#import "CalendarView.h"
#import "DatePickerController.h"
#import "DateSelect.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIBarButtonItem+AdditionalConvenienceConstructor.h"
#import "UIView+MutableFrame.h"

@interface CalendarViewController ()
  <CalendarViewDelegate,
   CalendarControlViewDelegate,
   PageViewDelegate,
   DatePickerControllerDelegate>

@property(strong, nonatomic, readwrite) NSDate *date;
@property(strong, nonatomic) UIToolbar *toolbar;
@property(strong, nonatomic) UIPopoverController *popover;

- (void)onCancel:(UIBarButtonItem *)sender;
- (void)onEvent:(UIBarButtonItem *)sender;
- (UIBarButtonItem *)eventButtonItem;
- (void)setCurrentYear:(NSInteger)year month:(NSInteger)month;
- (void)prevMonth;
- (void)nextMonth;
- (CalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (void)showDatePickerForPhoneWithPickerController:(DatePickerController *)pickerController;
- (void)showDatePickerForPadWithPickerController:(DatePickerController *)pickerController;
@end

@implementation CalendarViewController
static const CGFloat iPadCalendarButtonSize = 66.0;

- (id)init
{
    if ((self = [super init])) {
        NSDate *date = [NSDate date];
        NSInteger year = [date year];
        NSInteger month = [date month];
        _date = date;
       
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
            [_toolbar setBarStyle:UIBarStyleBlackOpaque];
            [_toolbar setItems:@[[UIBarButtonItem cancelButtonItemWithTarget:self action:@selector(onCancel:)],
                                 [UIBarButtonItem flexibleSpaceItem],
                                 [self eventButtonItem]]];
            [_toolbar sizeToFit];
        }

        _calendarViews = @[[self calendarViewWithYear:year month:month - 1],
                           [self calendarViewWithYear:year month:month],
                           [self calendarViewWithYear:year month:month + 1]];

        _calendarControllView = [[CalendarControlView alloc] initWithCalendarView:_calendarViews[1]];
        [_calendarControllView setFrameOriginY:_toolbar.bounds.size.height];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _calendarControllView.frame = CGRectZero;
            _toolbar.frame = CGRectZero;
        }

        _pageView = [[PageView alloc] initWithContentView:_calendarViews[1]
                                                    prevPage:_calendarViews[0]
                                                    nextPage:_calendarViews[2]];
        _pageView.frame = CGRectMake(0,
                                     _calendarControllView.frame.origin.y + _calendarControllView.frame.size.height,
                                     _pageView.frame.size.width,
                                     _pageView.frame.size.height);
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[self viewFrame]];

    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.calendarControllView];
    [self.view addSubview:self.pageView];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.calendarControllView setDelegate:self];
    [self.pageView setDelegate:self];
    [self.pageView setPage:1 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setDynamicCalendar:(BOOL)dynamicCalendar
{
    if (_dynamicCalendar != dynamicCalendar) {
        _dynamicCalendar = dynamicCalendar;
    }
    [self.pageView setPagingEnabled:_dynamicCalendar];
}

- (BOOL)isPopoverVisible
{
    return [self.popover isPopoverVisible];
}

- (void)presentPopoverAnimated:(BOOL)animated
{
    [self.popover presentPopoverFromRect:self.dateSelectButton.superview.frame
                                  inView:[[[[[UIApplication sharedApplication] delegate] window] rootViewController] view]
                permittedArrowDirections:UIPopoverArrowDirectionAny
                                animated:animated];
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
    if ([self.popover isPopoverVisible]) {
        [self.popover dismissPopoverAnimated:animated];
    }
}

- (UIButton *)dateSelectButton
{
    return self.calendarControllView.dateSelectButton;
}

- (UIButton *)prevButton
{
    return self.calendarControllView.prevButton;
}

- (UIButton *)nextButton
{
    return self.calendarControllView.nextButton;
}


#pragma mark - CalendarView

- (void)calendarView:(CalendarView *)calendarView
       didSelectDate:(NSDate *)date
{
    self.date = date;
    [self.delegate didSelectDate:date];
}


#pragma mark - CalendarControllView

- (NSDate *)calendarControlView:(CalendarControlView *)calendarControllView
           pressPrevMonthButton:(UIButton *)prevMonthButton
{
    [self prevMonth];
    self.date = [NSDate dateWithYear:[self.calendarViews[1] year]
                               month:[self.calendarViews[1] month]
                                 day:1];
    return self.date;
}

- (NSDate *)calendarControlView:(CalendarControlView *)calendarControllView
           pressNextMonthButton:(UIButton *)nextMonthBUtton
{
    [self nextMonth];
    self.date = [NSDate dateWithYear:[self.calendarViews[1] year]
                               month:[self.calendarViews[1] month]
                                 day:1];
    return self.date;
}

- (void)calendarControlView:(CalendarControlView *)calendarControllView
      pressDateSelectButton:(UIButton *)dateSelectButton
{
    DatePickerController *pickerViewController = [[DatePickerController alloc] initWithNibName:@"DatePickerController" bundle:nil];
    pickerViewController.year = [self.calendarControllView.currentDate year];
    pickerViewController.month = [self.calendarControllView.currentDate month];
    [pickerViewController setHideDayComponent:YES];
    [pickerViewController setDelegate:self];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self showDatePickerForPhoneWithPickerController:pickerViewController];
    } else {
        [self showDatePickerForPadWithPickerController:pickerViewController];
    }
}


#pragma mark - PageView

- (void)pageViewDidPrevPage:(PageView *)pageView
{
    [self.calendarViews[1] prevMonth];
    self.date = [NSDate dateWithYear:[self.calendarViews[1] year]
                               month:[self.calendarViews[1] month]
                                 day:1];
    [self.calendarControllView setCurrentDate:self.date];
    [pageView setPage:1 animated:NO];
    [self.calendarViews[0] prevMonth];
    [self.calendarViews[2] prevMonth];
}

- (void)pageViewDidNextPage:(PageView *)pageView
{
    [self.calendarViews[1] nextMonth];
    self.date = [NSDate dateWithYear:[self.calendarViews[1] year]
                               month:[self.calendarViews[1] month]
                                 day:1];
    [self.calendarControllView setCurrentDate:self.date];
    [pageView setPage:1 animated:NO];

    [self.calendarViews[2] nextMonth];
    [self.calendarViews[0] nextMonth];
}


#pragma mark - ViewSheet

- (void)viewSheetClickedCancelButton:(ViewSheet *)viewSheet
{
    [viewSheet dismissViewSheetAnimated:YES shoot:NO];
}


#pragma mark - DatePickerController

- (void)datePickerControllerDidCancel:(DatePickerController *)datePickerController
{
    [self.viewSheet dismissViewSheetAnimated:YES shoot:NO];
    [self.popover dismissPopoverAnimated:YES];
}

- (void)datePickerControllerDidDone:(DatePickerController *)datePickerController
                               year:(NSInteger)year
                              month:(NSInteger)month
                                day:(NSInteger)day
{
    [self.viewSheet dismissViewSheetAnimated:YES shoot:NO];
    [self.popover dismissPopoverAnimated:YES];
    [self setCurrentYear:year month:month];
}


#pragma mark - Extension

- (CGRect)viewFrame
{
    return CGRectMake(0,
                      0,
                      self.pageView.frame.size.width,
                      self.pageView.frame.origin.y
                      + self.pageView.frame.size.height);
}

#pragma mark - Private

- (void)onCancel:(UIBarButtonItem *)sender
{
    [self.actionDelegate calendarViewControllerDidCancel:self];
}

- (void)onEvent:(UIBarButtonItem *)sender
{
    [self.actionDelegate calendarViewControllerShouldShowEvent:self];
}

- (UIBarButtonItem *)eventButtonItem
{
    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"EVENT", nil)
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(onEvent:)];
}

- (void)setCurrentYear:(NSInteger)year month:(NSInteger)month
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarViews[0] setYear:year month:month - 1];
        [self.calendarViews[1] setYear:year month:month];
        [self.calendarViews[2] setYear:year month:month + 1];
    });

    self.date = [NSDate dateWithYear:year
                               month:month
                                 day:1];
    [self.calendarControllView setCurrentDate:self.date];
}

- (void)prevMonth
{
    for (CalendarView *calendarView in self.calendarViews) {
        [calendarView prevMonth];
    }
}

- (void)nextMonth
{
    for (CalendarView *calendarView in self.calendarViews) {
        [calendarView nextMonth];
    }
}

- (CalendarView *)calendarViewWithYear:(NSInteger)year
                                 month:(NSInteger)month
{
    CalendarView *calendarView = [[CalendarView alloc] initWithMargin:6.0];
    [calendarView setDelegate:self];
    [calendarView setYear:year month:month];

    return calendarView;
}

- (void)showDatePickerForPhoneWithPickerController:(DatePickerController *)pickerController
{
    self.viewSheet = [[ViewSheet alloc] initWithContentViewController:pickerController];
    [self.viewSheet showViewSheetAnimated:YES];
}

- (void)showDatePickerForPadWithPickerController:(DatePickerController *)pickerController
{
    pickerController.delegate = self;
    self.popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    [self presentPopoverAnimated:YES];
}
@end
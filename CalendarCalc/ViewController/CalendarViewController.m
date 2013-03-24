//
//  CCCalendarViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"
#import "CalendarControllView.h"
#import "WeekControllView.h"
#import "PageView.h"
#import "ViewSheet.h"
#import "YearMonthPickerController.h"
#import "DateSelect.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"

@interface CalendarViewController ()
  <CalendarViewDelegate,
   CalendarControllViewDelegate,
   WeekControllViewDelegate,
   PageViewDelegate,
   ViewSheetDelegate,
   YearMonthPickerControllerDelegate>

@property (strong, nonatomic, readwrite) NSDate *date;

- (CalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (void)setCurrentWithYearMonthPickerController:(YearMonthPickerController *)yearMonthController;
- (void)prevMonth;
- (void)nextMonth;
- (void)onYearMonthSelectDone:(UIBarButtonItem *)sender;
- (void)showYearMonthPickerForPhoneWithPickerController:(YearMonthPickerController *)pickerController;
- (void)showYearMonthPickerForPadWithPickerController:(YearMonthPickerController *)pickerController;
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
        _calendarViews = @[[self calendarViewWithYear:year month:month - 1],
                           [self calendarViewWithYear:year month:month],
                           [self calendarViewWithYear:year month:month + 1]];
        _calendarControllView = [[CalendarControllView alloc] initWithCalendarView:_calendarViews[1]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _calendarControllView.frame = CGRectZero;
        }
        
        _weekControllView = [[WeekControllView alloc] initWithCalendarView:_calendarViews[1]];
        _weekControllView.frame = CGRectMake(_weekControllView.frame.origin.x,
                                             _calendarControllView.frame.size.height,
                                             _weekControllView.frame.size.width,
                                             _weekControllView.frame.size.height);

        _pageView = [[PageView alloc] initWithContentView:_calendarViews[1]
                                                    prevPage:_calendarViews[0]
                                                    nextPage:_calendarViews[2]];
        _pageView.frame = CGRectMake(0,
                                     _weekControllView.frame.origin.y + _weekControllView.frame.size.height,
                                     _pageView.frame.size.width,
                                     _pageView.frame.size.height);
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         0,
                                                         _pageView.frame.size.width,
                                                         _pageView.frame.size.height
                                                         + _weekControllView.frame.size.height
                                                         + _calendarControllView.frame.size.height)];

    [self.view addSubview:_calendarControllView];
    [self.view addSubview:_weekControllView];
    [self.view addSubview:_pageView];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_calendarControllView setDelegate:self];
    [_weekControllView setDelegate:self];
    [_pageView setDelegate:self];
    [_pageView setPage:1 animated:NO];
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
    [_pageView setPagingEnabled:_dynamicCalendar];
}

- (UIButton *)dateSelectButton
{
    return _calendarControllView.dateSelectButton;
}

- (UIButton *)prevButton
{
    return _calendarControllView.prevButton;
}

- (UIButton *)nextButton
{
    return _calendarControllView.nextButton;
}

- (BOOL)isPopoverVisible
{
    return [_popover isPopoverVisible];
}

- (void)presentPopoverAnimated:(BOOL)animated
{
    [_popover presentPopoverFromRect:self.dateSelectButton.superview.frame
                              inView:[[[[[UIApplication sharedApplication] delegate] window] rootViewController] view]
            permittedArrowDirections:UIPopoverArrowDirectionAny
                            animated:animated];
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
    if ([_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:animated];
    }
}

#pragma mark - CalendarView

- (void)calendarView:(CalendarView *)calendarView
       didSelectDate:(NSDate *)date
{
    self.date = date;
    [self.delegate didSelectDate:date];
}


#pragma mark - CalendarControllView

- (NSDate *)calendarControllView:(CalendarControllView *)calendarControllView
            pressPrevMonthButton:(UIButton *)prevMonthButton
{
    [self prevMonth];
    self.date = [NSDate dateWithYear:[_calendarViews[1] year]
                               month:[_calendarViews[1] month]
                                 day:1];
    return self.date;
}

- (NSDate *)calendarControllView:(CalendarControllView *)calendarControllView
            pressNextMonthButton:(UIButton *)nextMonthBUtton
{
    [self nextMonth];
    self.date = [NSDate dateWithYear:[_calendarViews[1] year]
                               month:[_calendarViews[1] month]
                                 day:1];
    return self.date;
}

- (void)calendarControllView:(CalendarControllView *)calendarControllView
           pressDateSelectButton:(UIButton *)dateSelectButton
{
    YearMonthPickerController *pickerViewController = [[YearMonthPickerController alloc] init];
    pickerViewController.year = [_calendarControllView.currentDate year];
    pickerViewController.month = [_calendarControllView.currentDate month];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self showYearMonthPickerForPhoneWithPickerController:pickerViewController];
    } else {
        [self showYearMonthPickerForPadWithPickerController:pickerViewController];
    }
}


#pragma mark - WeekControllerView

- (void)weekControllView:(WeekControllView *)view
                    week:(Week)week
                      on:(BOOL)on
{
    [self.delegate didSelectWeek:week exclude:!on];
}


#pragma mark - PageView

- (void)pageViewDidPrevPage:(PageView *)pageView
{
    [_calendarViews[1] prevMonth];
    self.date = [NSDate dateWithYear:[_calendarViews[1] year]
                               month:[_calendarViews[1] month]
                                 day:1];
    [_calendarControllView setCurrentDate:self.date];
    [pageView setPage:1 animated:NO];
    [_calendarViews[0] prevMonth];
    [_calendarViews[2] prevMonth];
}

- (void)pageViewDidNextPage:(PageView *)pageView
{
    [_calendarViews[1] nextMonth];
    self.date = [NSDate dateWithYear:[_calendarViews[1] year]
                               month:[_calendarViews[1] month]
                                 day:1];
    [_calendarControllView setCurrentDate:self.date];
    [pageView setPage:1 animated:NO];

    [_calendarViews[2] nextMonth];
    [_calendarViews[0] nextMonth];
}


#pragma mark - ViewSheet

- (void)viewSheetClickedCancelButton:(ViewSheet *)viewSheet
{
    [viewSheet dismissContainerViewWithAnimated:YES];
}


#pragma mark - YearMonthPickerController

- (void)yearMonthPickearControllerDidDone:(YearMonthPickerController *)yearMonthPickerController
{
    if ([_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:YES];
    }
    [self setCurrentWithYearMonthPickerController:(YearMonthPickerController *)_popover.contentViewController];
}

#pragma mark - Private

- (void)setCurrentWithYearMonthPickerController:(YearMonthPickerController *)yearMonthController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_calendarViews[0] setYear:yearMonthController.year month:yearMonthController.month - 1];
        [_calendarViews[1] setYear:yearMonthController.year month:yearMonthController.month];
        [_calendarViews[2] setYear:yearMonthController.year month:yearMonthController.month + 1];
    });

    self.date = [NSDate dateWithYear:yearMonthController.year
                               month:yearMonthController.month
                                 day:1];
    [_calendarControllView setCurrentDate:self.date];
}

- (void)prevMonth
{
    for (CalendarView *calendarView in _calendarViews) {
        [calendarView prevMonth];
    }
}

- (void)nextMonth
{
    for (CalendarView *calendarView in _calendarViews) {
        [calendarView nextMonth];
    }
}

- (CalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month
{
    CGSize calendarButtonSize = CGSizeZero;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        calendarButtonSize = CGSizeMake(44.0, 44.0);
    } else {
        calendarButtonSize = CGSizeMake(66.0, 66.0);
    }
    
    CalendarView *calendarView = [[CalendarView alloc] initWithMargin:6.0];
    [calendarView setDelegate:self];
    [calendarView setYear:year month:month];

    return calendarView;
}

- (void)onYearMonthSelectDone:(UIBarButtonItem *)sender
{
    [_viewSheet dismissContainerViewWithAnimated:YES];
    [self setCurrentWithYearMonthPickerController:(YearMonthPickerController *)_viewSheet.contentViewController];
}

- (void)showYearMonthPickerForPhoneWithPickerController:(YearMonthPickerController *)pickerController
{
    _viewSheet = [[ViewSheet alloc] initWithContentViewController:pickerController];
    [_viewSheet setRightButton:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(onYearMonthSelectDone:)]];
    _viewSheet.delegate = self;

    [_viewSheet showInView:self.view animated:YES];
}

- (void)showYearMonthPickerForPadWithPickerController:(YearMonthPickerController *)pickerController
{
    pickerController.delegate = self;
    _popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    [self presentPopoverAnimated:YES];
}
@end
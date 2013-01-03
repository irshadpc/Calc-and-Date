//
//  CCCalendarViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarViewController.h"
#import "ASCCalendarView.h"
#import "ASCCalendarControllView.h"
#import "CCWeekControllView.h"
#import "ASCPageView.h"
#import "CCViewSheet.h"
#import "CCYearMonthPickerController.h"
#import "CCDateSelect.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"

@interface CCCalendarViewController ()
  < 
    ASCCalendarViewDelegate,
    ASCCalendarControllViewDelegate,
    CCWeekControllViewDelegate,
    ASCPageViewDelegate,
    CCViewSheetDelegate,
    CCYearMonthPickerControllerDelegate
  >
@property (strong, nonatomic, readwrite) NSDate *date;

- (ASCCalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (void)setCurrentWithYearMonthPickerController:(CCYearMonthPickerController *)yearMonthController;
- (void)prevMonth;
- (void)nextMonth;
- (void)onYearMonthSelectDone:(UIBarButtonItem *)sender;
- (void)showYearMonthPickerForPhoneWithPickerController:(CCYearMonthPickerController *)pickerController;
- (void)showYearMonthPickerForPadWithPickerController:(CCYearMonthPickerController *)pickerController;
@end

@implementation CCCalendarViewController

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
        _calendarControllView = [[ASCCalendarControllView alloc] initWithCalendarView:_calendarViews[1]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _calendarControllView.frame = CGRectZero;
        }
        
        _weekControllView = [[CCWeekControllView alloc] initWithCalendarView:_calendarViews[1]];
        _weekControllView.frame = CGRectMake(_weekControllView.frame.origin.x,
                                             _calendarControllView.frame.size.height,
                                             _weekControllView.frame.size.width,
                                             _weekControllView.frame.size.height);

        _pageView = [[ASCPageView alloc] initWithContentView:_calendarViews[1]
                                                    prevPage:_calendarViews[0]
                                                    nextPage:_calendarViews[2]];
        _pageView.frame = CGRectMake(0,
                                     _weekControllView.frame.origin.y + _weekControllView.frame.size.height,
                                     _pageView.frame.size.width,
                                     _pageView.frame.size.height);
        
        self.view.frame = CGRectMake(0,
                                     0,
                                     _pageView.frame.size.width,
                                     _pageView.frame.size.height
                                     + _weekControllView.frame.size.height
                                     + _calendarControllView.frame.size.height);
        
        [self.view addSubview:_calendarControllView];
        [self.view addSubview:_weekControllView];
        [self.view addSubview:_pageView];
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    }
    return self;
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

#pragma mark - ASCCalendarView

- (void)calendarView:(ASCCalendarView *)view
     onTouchUpInside:(NSDate *)date
{
    self.date = date;
    [self.delegate didSelectDate:date];
}


#pragma mark - ASCCalendarControllView

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
            pressPrevMonthButton:(UIButton *)prevMonthButton
{
    [self prevMonth];
    self.date = [NSDate dateWithYear:[_calendarViews[1] year]
                               month:[_calendarViews[1] month]
                                 day:1];
    return self.date;
}

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
            pressNextMonthButton:(UIButton *)nextMonthBUtton
{
    [self nextMonth];
    self.date = [NSDate dateWithYear:[_calendarViews[1] year]
                               month:[_calendarViews[1] month]
                                 day:1];
    return self.date;
}

- (void)calendarControllView:(ASCCalendarControllView *)calendarControllView
       pressDateSelectButton:(UIButton *)dateSelectButton
{
    CCYearMonthPickerController *pickerViewController = [[CCYearMonthPickerController alloc] init];
    pickerViewController.year = [_calendarControllView.currentDate year];
    pickerViewController.month = [_calendarControllView.currentDate month];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self showYearMonthPickerForPhoneWithPickerController:pickerViewController];
    } else {
        [self showYearMonthPickerForPadWithPickerController:pickerViewController];
    }
}


#pragma mark - CCWeekControllerView

- (void)weekControllView:(CCWeekControllView *)view
                    week:(ASCWeek)week
                      on:(BOOL)on
{
    [self.delegate didSelectWeek:week exclude:!on];
}


#pragma mark - ASCPageView

- (void)pageViewDidPrevPage:(ASCPageView *)pageView
{
    [_calendarViews[1] prevMonth];
    [_calendarControllView setCurrentDate:[NSDate dateWithYear:[_calendarViews[1] year]
                                                         month:[_calendarViews[1] month]
                                                           day:1]];
    [pageView setPage:1 animated:NO];
    [_calendarViews[0] prevMonth];
    [_calendarViews[2] prevMonth];
}

- (void)pageViewDidNextPage:(ASCPageView *)pageView
{
    [_calendarViews[1] nextMonth];
    [_calendarControllView setCurrentDate:[NSDate dateWithYear:[_calendarViews[1] year]
                                                         month:[_calendarViews[1] month]
                                                           day:1]];
    [pageView setPage:1 animated:NO];

    [_calendarViews[2] nextMonth];
    [_calendarViews[0] nextMonth];
}


#pragma mark - CCViewSheet

- (void)viewSheetClickedCancelButton:(CCViewSheet *)viewSheet
{
    [viewSheet dismissContainerViewWithAnimated:YES];
}


#pragma mark - CCYearMonthPickerController

- (void)yearMonthPickearControllerDidDone:(CCYearMonthPickerController *)yearMonthPickerController
{
    if ([_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:YES];
    }
    [self setCurrentWithYearMonthPickerController:(CCYearMonthPickerController *)_popover.contentViewController];
}

#pragma mark - Private

- (void)setCurrentWithYearMonthPickerController:(CCYearMonthPickerController *)yearMonthController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_calendarViews[0] reloadCalendarViewWithYear:yearMonthController.year month:yearMonthController.month - 1];
        [_calendarViews[1] reloadCalendarViewWithYear:yearMonthController.year month:yearMonthController.month];
        [_calendarViews[2] reloadCalendarViewWithYear:yearMonthController.year month:yearMonthController.month + 1];
    });

    self.date = [NSDate dateWithYear:yearMonthController.year
                               month:yearMonthController.month
                                 day:1];
    [_calendarControllView setCurrentDate:self.date];
}

- (void)prevMonth
{
    for (ASCCalendarView *calendarView in _calendarViews) {
        [calendarView prevMonth];
    }
}

- (void)nextMonth
{
    for (ASCCalendarView *calendarView in _calendarViews) {
        [calendarView nextMonth];
    }
}

- (ASCCalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month
{
    CGSize calendarButtonSize = CGSizeZero;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        calendarButtonSize = CGSizeMake(44.0, 44.0);
    } else {
        calendarButtonSize = CGSizeMake(66.0, 66.0);
    }
    
    ASCCalendarView *calendarView = [[ASCCalendarView alloc] initWithCalendarButtonSize:calendarButtonSize];
    [calendarView setDelegate:self];
    [calendarView reloadCalendarViewWithYear:year month:month];

    return calendarView;
}

- (void)onYearMonthSelectDone:(UIBarButtonItem *)sender
{
    [_viewSheet dismissContainerViewWithAnimated:YES];
    [self setCurrentWithYearMonthPickerController:(CCYearMonthPickerController *)_viewSheet.contentViewController];
}

- (void)showYearMonthPickerForPhoneWithPickerController:(CCYearMonthPickerController *)pickerController
{
    _viewSheet = [[CCViewSheet alloc] initWithContentViewController:pickerController];
    [_viewSheet setRightButton:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(onYearMonthSelectDone:)]];
    _viewSheet.delegate = self;

    [_viewSheet showInView:self.view animated:YES];
}

- (void)showYearMonthPickerForPadWithPickerController:(CCYearMonthPickerController *)pickerController
{
    pickerController.delegate = self;
    _popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    [_popover presentPopoverFromRect:self.dateSelectButton.superview.frame
                              inView:[[[[[UIApplication sharedApplication] delegate] window] rootViewController] view]
            permittedArrowDirections:UIPopoverArrowDirectionRight
                            animated:YES];
}

@end

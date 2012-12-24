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
#import "ASCPageView.h"
#import "CCViewSheet.h"
#import "CCYearMonthPickerController.h"
#import "CCDateSelect.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"

@interface CCCalendarViewController ()
  <ASCCalendarViewDelegate, ASCCalendarControllViewDelegate, ASCPageViewDelegate, CCViewSheetDelegate>
- (ASCCalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (void)prevMonth;
- (void)nextMonth;
@end

@implementation CCCalendarViewController

- (id)init
{
    if ((self = [super init])) {
        NSDate *date = [NSDate date];
        NSInteger year = [date year];
        NSInteger month = [date month];
        _calendarViews = @[[self calendarViewWithYear:year month:month - 1],
                           [self calendarViewWithYear:year month:month],
                           [self calendarViewWithYear:year month:month + 1]];
        _calendarControllView = [[ASCCalendarControllView alloc] initWithCalendarView:_calendarViews[1]];

        _pageView = [[ASCPageView alloc] initWithContentView:_calendarViews[1]
                                                    prevPage:_calendarViews[0]
                                                    nextPage:_calendarViews[2]];
        _pageView.frame = CGRectMake(0,
                                     _calendarControllView.frame.size.height,
                                     _pageView.frame.size.width,
                                     _pageView.frame.size.height);
        
        self.view.frame = CGRectMake(0,
                                     0,
                                     _pageView.frame.size.width,
                                     _pageView.frame.size.height + _calendarControllView.frame.size.height);
        [self.view addSubview:_calendarControllView];
        [self.view addSubview:_pageView];
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_calendarControllView setDelegate:self];
    [_pageView setDelegate:self];
    [_pageView setPage:1 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Private

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
    ASCCalendarView *calendarView = [[ASCCalendarView alloc] initWithFrame:CGRectZero];

    [calendarView setDelegate:self];
    [calendarView reloadCalendarViewWithYear:year month:month];

    return calendarView;
}


#pragma mark - ASCCalendarView

- (void)calendarView:(ASCCalendarView *)view
     onTouchUpInside:(NSDate *)date
{
    [self.delegate didSelectDate:date];
}


#pragma mark - ASCCalendarControllView

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
            pressPrevMonthButton:(UIButton *)prevMonthButton
{
    [self prevMonth];
    return [NSDate dateWithYear:[_calendarViews[1] year]
                          month:[_calendarViews[1] month]
                            day:1];
}

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
            pressNextMonthButton:(UIButton *)nextMonthBUtton
{
    [self nextMonth];
    return [NSDate dateWithYear:[_calendarViews[1] year]
                          month:[_calendarViews[1] month]
                            day:1];
}

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
           pressDateSelectButton:(UIButton *)dateSelectButton
{

    CCYearMonthPickerController *pickerController = [[CCYearMonthPickerController alloc] init];
    pickerController.year = [_calendarControllView.currentDate year];
    pickerController.month = [_calendarControllView.currentDate month];

    CCViewSheet *viewSheet = [[CCViewSheet alloc] initWithContentViewController:pickerController];
    viewSheet.delegate = self;

    [viewSheet showInView:self.view animated:YES];
    return [NSDate date];
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

@end

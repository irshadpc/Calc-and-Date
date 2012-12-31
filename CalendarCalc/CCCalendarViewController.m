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
  <ASCCalendarViewDelegate, ASCCalendarControllViewDelegate, ASCPageViewDelegate, CCViewSheetDelegate>

- (ASCCalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (void)setCurrentYear:(NSInteger)year month:(NSInteger)month;
- (void)prevMonth;
- (void)nextMonth;
- (void)onPickerToolbarDone:(UIBarButtonItem *)sender;
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
    [_pageView setDelegate:self];
    [_pageView setPage:1 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Private

- (void)setCurrentYear:(NSInteger)year 
                 month:(NSInteger)month
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_calendarViews[0] reloadCalendarViewWithYear:year month:month - 1];
        [_calendarViews[1] reloadCalendarViewWithYear:year month:month];
        [_calendarViews[2] reloadCalendarViewWithYear:year month:month + 1];
    });

    [_calendarControllView setCurrentDate:[NSDate dateWithYear:year
                                                         month:month
                                                           day:1]];
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

- (void)calendarControllView:(ASCCalendarControllView *)calendarControllView
       pressDateSelectButton:(UIButton *)dateSelectButton
{
    CCYearMonthPickerController *pickerViewController = [[CCYearMonthPickerController alloc] init];
    pickerViewController.year = [_calendarControllView.currentDate year];
    pickerViewController.month = [_calendarControllView.currentDate month];

    _viewSheet = [[CCViewSheet alloc] initWithContentViewController:pickerViewController];
    [_viewSheet setRightButton:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                            target:self 
                                                                            action:@selector(onPickerToolbarDone:)]];
    _viewSheet.delegate = self;

    [_viewSheet showInView:self.view animated:YES];
}

- (void)onPickerToolbarDone:(UIBarButtonItem *)sender
{
    [_viewSheet dismissContainerViewWithAnimated:YES];
    
    [self setCurrentYear:[(CCYearMonthPickerController *)_viewSheet.contentViewController year]
                   month:[(CCYearMonthPickerController *)_viewSheet.contentViewController month]];
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

- (void)viewSheet:(CCViewSheet *)viewSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"INDEX: %d", buttonIndex);
}


@end

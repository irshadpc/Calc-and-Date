//
//  CCViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCViewController.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "ASCCalendarView.h"
#import "ASCCalendarControllView.h"
#import "ASCPageView.h"
#import "CCViewSheet.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSString+Date.h"

@interface CCViewController ()
  <ASCCalendarViewDelegate, ASCCalendarControllViewDelegate, ASCPageViewDelegate, CCViewSheetDelegate>

// properties
@property (strong, nonatomic) CCCalendarCalc *calendarCalc;
@property (strong, nonatomic) CCViewSheet *currentSheet;
@property (strong, nonatomic) NSMutableArray *calendarViews;
@property (strong, nonatomic) ASCCalendarControllView *calendarControllView;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *indicatorText;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *decimalButton;

// methods
- (IBAction)onFunction:(UIButton *)sender;
- (IBAction)onNumber:(UIButton *)sender;
- (IBAction)onDate:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;

- (void)prevMonth;
- (void)nextMonth;

- (ASCCalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (UIImage *)calendarImage;
@end

@implementation CCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _calendarCalc = [[CCCalendarCalc alloc] init];
        NSString *soundPath = [[NSBundle mainBundle] pathForResource: @"key_click"
                                                              ofType: @"aif"];
        NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath: soundPath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL: soundUrl error: nil];
        [_player setVolume: 0.5];
        [_player prepareToPlay];

        NSInteger currentYear = [[NSDate date] year];
        NSInteger currentMonth = [[NSDate date] month];
        _calendarViews = [[NSMutableArray alloc] init];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_calendarViews addObject:[self calendarViewWithYear:currentYear month:currentMonth - 1]];
            [_calendarViews addObject:[self calendarViewWithYear:currentYear month:currentMonth]];
            [_calendarViews addObject:[self calendarViewWithYear:currentYear month:currentMonth + 1]];
        });
       
        _calendarControllView = [[ASCCalendarControllView alloc] initWithFrame:CGRectZero];
        [_calendarControllView setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDate *date = [NSDate date];
    [self.dateButton setTitle: [NSString stringWithYear: [date year]
                                                  month: [date month]]
                     forState: UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFunction:(UIButton *)sender
{
    self.display.text = [[self.calendarCalc inputFunction:sender.tag] displayResult];
}

- (IBAction)onNumber:(UIButton *)sender
{
    self.display.text = [[self.calendarCalc inputInteger:sender.tag] displayResult];
}

- (IBAction)onDate:(UIButton *)sender
{
    ASCPageView *pageView = [[ASCPageView alloc] initWithContentView:self.calendarViews[0]];
    [pageView addContentView:self.calendarViews[1]];
    [pageView addContentView:self.calendarViews[2]];
    [pageView setInfinitePage:YES];
    [pageView setDelegate:self];
    [pageView setPage:1 animated:NO];
    CGRect pageViewFrame = pageView.frame;
    pageViewFrame.origin.y += 44.0;
    pageView.frame = pageViewFrame;

    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:self.calendarControllView];
    [view addSubview:pageView];
    view.frame = CGRectMake(0, 
                            0, 
                            pageView.frame.size.width, 
                            pageView.frame.size.height + self.calendarControllView.frame.size.height);

    self.currentSheet = [[CCViewSheet alloc] initWithContentView:view];
    [self.currentSheet setDelegate:self];
    [self.currentSheet showInView:self.view animated:YES];
}

- (IBAction)onClick:(UIButton *)sender
{
    [_player setCurrentTime:0];
    [_player play];
}

- (void)prevMonth
{
    for (ASCCalendarView *calendarView in self.calendarViews) {
        [calendarView prevMonth];
    }
    [self.dateButton setTitle: [NSString stringWithYear: [self.calendarViews[1] year]
                                                 month: [self.calendarViews[1] month]]
                     forState: UIControlStateNormal];
}

- (void)nextMonth
{
    for (ASCCalendarView *calendarView in self.calendarViews) {
        [calendarView nextMonth];
    }
    [self.dateButton setTitle: [NSString stringWithYear: [self.calendarViews[1] year]
                                                  month: [self.calendarViews[1] month]]
                     forState: UIControlStateNormal];
}

- (ASCCalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month
{
    ASCCalendarView *calendarView = [[ASCCalendarView alloc] initWithFrame:CGRectZero];
    [calendarView setImage:[self calendarImage] forState:UIControlStateNormal];
    [calendarView setDelegate:self];
    [calendarView reloadCalendarViewWithYear:year month:month];
   
    return calendarView;
}

- (UIImage *)calendarImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"calendar_day"];
    }
    return image;
}


#pragma mark - ASCCalendarView

- (void)calendarView:(ASCCalendarView *)view
     onTouchUpInside:(NSDate *)date
{
    self.display.text = [[self.calendarCalc inputDate:date] displayResult];
    [self.currentSheet dismissContainerViewWithAnimated:YES];
}


#pragma mark - ASCCalendarControllView

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
            pressPrevMonthButton:(UIButton *)prevMonthButton
{
    [self prevMonth];
    return [NSDate dateWithYear: [self.calendarViews[1] year]
                          month: [self.calendarViews[1] month]
                            day: 1];
}

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
            pressNextMonthButton:(UIButton *)nextMonthBUtton
{
    [self nextMonth];
    return [NSDate dateWithYear: [self.calendarViews[1] year]
                          month: [self.calendarViews[1] month]
                            day: 1];
}

- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView
           pressDateSelectButton:(UIButton *)dateSelectButton
{
    return [NSDate date];
}


#pragma mark - ASCPageView

- (void)pageViewDidFirstPage:(ASCPageView *)pageView
{
    [self.calendarViews[1] prevMonth];
    [self.calendarViews[2] prevMonth];
    [pageView setPage:1 animated:NO];
    [self.calendarViews[0] prevMonth];

    [self.calendarControllView setCurrentDate:[NSDate dateWithYear: [self.calendarViews[1] year]
                                                             month: [self.calendarViews[1] month]
                                                               day: 1]];
}

- (void)pageViewDidLastPage:(ASCPageView *)pageView
{
    [self.calendarViews[1] nextMonth];
    [self.calendarViews[0] nextMonth];
    [pageView setPage:1 animated:NO];
    [self.calendarViews[2] nextMonth];

    [self.calendarControllView setCurrentDate:[NSDate dateWithYear: [self.calendarViews[1] year]
                                                             month: [self.calendarViews[1] month]
                                                               day: 1]];
}


#pragma mark - CCContainerView

- (void)viewSheetClickedCancelButton:(CCViewSheet *)viewSheet
{
    [viewSheet dismissContainerViewWithAnimated:YES];
}

- (void)viewSheet:(CCViewSheet *)viewSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"EVENT");
    }
}

@end

//
//  CalendarCalcViewController_iPhone.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/05/10.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPhone.h"
#import "AppDelegate.h"
#import "AppDelegate+Setting.h"
#import "EventViewController.h"
#import "SettingViewController.h"
#import "CopybleLabel.h"
#import "ViewSheet.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcValueFormatter.h"
#import "DateSelect.h"
#import "CalendarViewController+Week.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CalendarCalcViewController_iPhone ()
< SettingViewControllerDelegate,
  DateSelect,
  CalendarViewControllerDelegate,
  UIPopoverControllerDelegate,
  EventViewControllerDelegate
>

@property(weak, nonatomic) IBOutlet CopybleLabel *display;
@property(weak, nonatomic) IBOutlet UILabel *indicator;
@property(weak, nonatomic) IBOutlet UIButton *dateButton;
@property(weak, nonatomic) IBOutlet UIButton *decimalButton;
@property(weak, nonatomic) IBOutlet UIButton *clearButton;
@property(strong, nonatomic) CalendarViewController *calendarViewController;
@property(strong, nonatomic) EventViewController *eventViewController;
@property(strong, nonatomic) ViewSheet *currentViewSheet;
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValue *result;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@property(weak, nonatomic) AVAudioPlayer *player;

- (IBAction)onCalcKey:(UIButton *)sender;
- (IBAction)onDateKey:(UIButton *)sender;
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;
- (void)setupSettings;
- (void)configureView;
- (void)configureDateButtonWithDate:(NSDate *)date;
@end


@implementation CalendarCalcViewController_iPhone
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _calcController = [[CalcController alloc] init];
        _formatter = [[CalcValueFormatter alloc] init];
        _calendarViewController = [[CalendarViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.decimalButton setTitle:[NSString decimalSeparator]
                        forState:UIControlStateNormal];
    [self.calendarViewController showWeekView];
    [self.calendarViewController setDelegate:self];
    [self.calendarViewController setActionDelegate:self];
    [self setupSettings];
    [self configureView];
    [self configureDateButtonWithDate:[NSDate date]];
    [self setPlayer:[(AppDelegate *)[[UIApplication sharedApplication] delegate] player]];
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [self setIndicator:nil];
    [self setDecimalButton:nil];
    [self setClearButton:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)canPerformAction:(SEL)action
              withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(paste:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)paste:(id)sender
{
    NSString *string = [[UIPasteboard generalPasteboard] string];
    if (!string) {
        return;
    }

    self.result = [self.calcController setStringValue:string];
    [self configureView];
}


#pragma mark - Action

- (IBAction)onCalcKey:(UIButton *)sender
{
    self.result = [self.calcController inputInteger:sender.tag];
    [self configureView];
}

- (IBAction)onDateKey:(UIButton *)sender
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
    
    self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.calendarViewController];
    [self.currentViewSheet showViewSheetAnimated:YES];
}

- (IBAction)onSetting:(UIButton *)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController"
                                                                                           bundle:nil];
    [settingViewController setDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    [navController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navController animated:YES completion:nil];

}

- (IBAction)onClick:(UIButton *)sender
{
    [self.player setCurrentTime:0];
    [self.player play];
}


#pragma mark - DateSelect

- (void)didSelectDate:(NSDate *)date
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
    
    self.result = [self.calcController inputDate:date];
    [self configureView];
    [self configureDateButtonWithDate:date];
}

- (void)didSelectWeek:(Week)week
              exclude:(BOOL)exclude
{
    [self.calcController setWeek:week exclude:exclude];
}


#pragma mark - CalendarViewController

- (void)calendarViewControllerDidCancel:(CalendarViewController *)calendarViewController
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
}

- (void)calendarViewControllerShouldShowEvent:(CalendarViewController *)viewController
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];

    if (!self.eventViewController) {
        self.eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController"
                                                                         bundle:nil];
        [self.eventViewController setDelegate:self];
    }
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [self.eventViewController setEnabledEventColor:[appDelegate eventColorOption]];
    self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.eventViewController];
    [self.currentViewSheet showViewSheetAnimated:YES];
}


#pragma mark - SettingViewController

- (void)settingViewControllerDidFinish:(SettingViewController *)settingViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];

    if (settingViewController.isEventSettingChanged) {
        [self.eventViewController reloadEvents];
    }

    [self setupSettings];
}


#pragma mark - EventViewController

- (void)eventViewControllerDidCancel:(EventViewController *)eventViewController
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];
}

- (void)eventViewControllerDidDone:(EventViewController *)eventViewController
{
    [self.currentViewSheet dismissViewSheetAnimated:YES shoot:NO];

    NSDate *date = [eventViewController selectedDate];
    self.result = [self.calcController inputDate:date];
    [self configureView];
    [self configureDateButtonWithDate:date];
}


#pragma mark - Private


- (void)setupSettings
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [self.calcController setIncludeStartDay:[appDelegate includeStartDayOption]];
    [self.calendarViewController setDynamicCalendar:[appDelegate dynamicCalendarOption]];
}

- (void)configureView
{
    self.display.text = self.result ? [self.formatter displayValueWithCalcValue:self.result] : @"0";
    self.indicator.text = [NSString stringWithFunction:[self.calcController currentFunction]];
    [self.clearButton setTitle:[self.calcController isAllCleared] ? @"AC" : @"C"
                      forState:UIControlStateNormal];
}

- (void)configureDateButtonWithDate:(NSDate *)date
{
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]]
                     forState:UIControlStateNormal];
}
@end

//
//  CCCalendarCalcViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController.h"
#import "CalendarCalcViewController_Common.h"
#import "CalendarCalcViewController+iPad.h"
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

@interface CalendarCalcViewController ()
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
@property(strong, nonatomic) UIPopoverController *settingPopover;
@property(strong, nonatomic) ViewSheet *currentViewSheet;
@property(strong, nonatomic) UIPopoverController *currentPopover;
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValue *result;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@property(weak, nonatomic) AVAudioPlayer *player;

- (IBAction)onCalcKey:(UIButton *)sender;
- (IBAction)onDateKey:(UIButton *)sender;
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;
- (IBAction)onEvent:(UIButton *)sender;
- (void)presentCalendarViewController;
- (void)presentEventViewController:(UIButton *)sender;
- (void)setupSettings;
- (void)configureView;
- (void)configureDateButtonWithDate:(NSDate *)date;
- (void)dismissContentViewControllerAnimated:(BOOL)animated;
- (void)presentContentViewControllerAnimated:(BOOL)animated fromRect:(CGRect)rect;
@end


@implementation CalendarCalcViewController
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
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self setupView];
    }
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self setupLayoutWithOrientation:toInterfaceOrientation];
    }
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
    
    [self.calcController inputNumberString:string];
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
    [self presentCalendarViewController];
}

- (IBAction)onSetting:(UIButton *)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController"
                                                                                           bundle:nil];
    [settingViewController setDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    [navController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:navController animated:YES completion:nil];
    } else {
        [self.settingPopover dismissPopoverAnimated:YES];
        self.settingPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
        [settingViewController setPopover:self.settingPopover];
        self.settingPopover.delegate = self;
        [self.settingPopover presentPopoverFromRect:sender.frame
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
    }
}

- (IBAction)onClick:(UIButton *)sender
{
    [self.player setCurrentTime:0];
    [self.player play];
}

- (IBAction)onEvent:(UIButton *)sender
{
    [self presentEventViewController:sender];
}


#pragma mark - DateSelect

- (void)didSelectDate:(NSDate *)date
{
    [self dismissContentViewControllerAnimated:YES];
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
    [self dismissContentViewControllerAnimated:YES];
}

- (void)calendarViewControllerShouldShowEvent:(CalendarViewController *)viewController
{
    [self presentEventViewController:nil];
}


#pragma mark - SettingViewController

- (void)settingViewControllerDidFinish:(SettingViewController *)settingViewController
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.settingPopover dismissPopoverAnimated:YES];
    }
    [self setupSettings];
}

- (void)settingViewControllerDidChangedCalendarSetting:(SettingViewController *)settingViewController
{
    [self.eventViewController reloadEvents];
}

#pragma mark - EventViewController

- (void)eventViewControllerDidCancel:(EventViewController *)eventViewController
{
    [self dismissContentViewControllerAnimated:YES];
}

- (void)eventViewControllerDidDone:(EventViewController *)eventViewController
{
    NSDate *date = [eventViewController selectedDate];
    [self dismissContentViewControllerAnimated:YES];
    self.result = [self.calcController inputDate:date];
    [self configureView];
    [self configureDateButtonWithDate:date];
}


#pragma mark - UIPopoverController

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == self.settingPopover) {
        UINavigationController *navController = (UINavigationController *)[popoverController contentViewController];
        [[navController childViewControllers][0] saveSettings];
        [self setupSettings];
    }
    return YES;
}


#pragma mark - Private

- (void)presentCalendarViewController
{
    [self dismissContentViewControllerAnimated:YES];
    self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.calendarViewController];
    [self presentContentViewControllerAnimated:YES fromRect:CGRectZero];
}

- (void)presentEventViewController:(UIButton *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController"
                                                                         bundle:nil];
        [self.eventViewController setDelegate:self];
    }

    [self.eventViewController setEnabledEventColor:[(AppDelegate *)[[UIApplication sharedApplication] delegate] eventColorOption]];

    [self dismissContentViewControllerAnimated:YES];
   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.eventViewController];
    } else {
        self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:self.eventViewController];
        self.currentPopover.delegate = self;
    }
    
    [self presentContentViewControllerAnimated:YES fromRect:sender.frame];
}

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

- (void)presentContentViewControllerAnimated:(BOOL)animated fromRect:(CGRect)rect
{
    [self.currentViewSheet showViewSheetAnimated:animated];
    [self.currentPopover presentPopoverFromRect:rect
                                         inView:self.view
                       permittedArrowDirections:UIPopoverArrowDirectionAny
                                       animated:animated];
}

- (void)dismissContentViewControllerAnimated:(BOOL)animated
{
    [self.currentViewSheet dismissViewSheetAnimated:animated shoot:NO];
    [self.currentPopover dismissPopoverAnimated:animated];
}
@end

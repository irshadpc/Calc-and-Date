//
//  CalendarCalcViewController_iPad.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/05/10.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPad.h"
#import "CalendarCalcViewController_iPad_Common.h"
#import "CalendarCalcViewController_iPad+Layout.h"
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

@interface CalendarCalcViewController_iPad ()
< SettingViewControllerDelegate,
  DateSelect,
  UIPopoverControllerDelegate,
  EventViewControllerDelegate
>

@property(weak, nonatomic) IBOutlet CopybleLabel *display;
@property(weak, nonatomic) IBOutlet UILabel *indicator;
@property(weak, nonatomic) IBOutlet UIButton *decimalButton;
@property(strong, nonatomic) UIPopoverController *settingPopover;
@property(strong, nonatomic) ViewSheet *currentViewSheet;
@property(strong, nonatomic) UIPopoverController *eventPopover;
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) EventViewController *eventViewController;
@property(strong, nonatomic) CalcValue *result;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@property(weak, nonatomic) AVAudioPlayer *player;

- (IBAction)onCalcKey:(UIButton *)sender;
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;
- (IBAction)onEvent:(UIButton *)sender;
- (void)setupSettings;
- (void)configureView;
@end


@implementation CalendarCalcViewController_iPad {
    BOOL _isDateSelectPopoverVisible;
    BOOL _isEventPopoverVisible;
}

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
    [self.eventButton setTitle:NSLocalizedString(@"EVENT", nil)
                      forState:UIControlStateNormal];
    [self.calendarViewController showWeekView];
    [self.calendarViewController setDelegate:self];
    [self setupSettings];
    [self configureView];
    [self setPlayer:[(AppDelegate *)[[UIApplication sharedApplication] delegate] player]];
    [self setupView];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return toInterfaceOrientation == UIInterfaceOrientationMaskPortrait;
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:0.25 animations:^ {
        [self setupLayoutWithOrientation:toInterfaceOrientation];
    }];
    _isDateSelectPopoverVisible = [self.calendarViewController isPopoverVisible];
    _isEventPopoverVisible = [self.eventPopover isPopoverVisible];

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (_isDateSelectPopoverVisible) {
        [self.calendarViewController presentPopoverAnimated:YES];
    }
    if (_isEventPopoverVisible) {
        [self.eventPopover presentPopoverFromRect:self.eventButton.frame
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
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

    self.result = [self.calcController setStringValue:string];
    [self configureView];
}


#pragma mark - Action

- (IBAction)onCalcKey:(UIButton *)sender
{
    self.result = [self.calcController inputInteger:sender.tag];
    [self configureView];
}

- (IBAction)onSetting:(UIButton *)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController"
                                                                                           bundle:nil];
    [settingViewController setDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    [navController.navigationBar setBarStyle:UIBarStyleBlackOpaque];

    [self.settingPopover dismissPopoverAnimated:YES];
    self.settingPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [settingViewController setPopover:self.settingPopover];
    self.settingPopover.delegate = self;
    [self.settingPopover presentPopoverFromRect:sender.frame
                                         inView:self.view
                       permittedArrowDirections:UIPopoverArrowDirectionAny
                                       animated:YES];
}

- (IBAction)onClick:(UIButton *)sender
{
    [self.player setCurrentTime:0];
    [self.player play];
}

- (IBAction)onEvent:(UIButton *)sender
{
    [self.eventPopover dismissPopoverAnimated:YES];

    if (!self.eventViewController) {
        self.eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController"
                                                                         bundle:nil];
        [self.eventViewController setDelegate:self];
    }
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [self.eventViewController setEnabledEventColor:[appDelegate eventColorOption]];
    
    self.eventPopover = [[UIPopoverController alloc] initWithContentViewController:self.eventViewController];
    self.eventPopover.delegate = self;
    [self.eventPopover presentPopoverFromRect:sender.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
}


#pragma mark - DateSelect

- (void)didSelectDate:(NSDate *)date
{
    self.result = [self.calcController inputDate:date];
    [self configureView];
}

- (void)didSelectWeek:(Week)week
              exclude:(BOOL)exclude
{
    [self.calcController setWeek:week exclude:exclude];
}


#pragma mark - EventViewController

- (void)eventViewControllerDidCancel:(EventViewController *)eventViewController
{
    [self.eventPopover dismissPopoverAnimated:YES];
}

- (void)eventViewControllerDidDone:(EventViewController *)eventViewController
{
    [self.eventPopover dismissPopoverAnimated:YES];
    
    NSDate *date = [eventViewController selectedDate];
    self.result = [self.calcController inputDate:date];
    [self configureView];
}


#pragma mark - UIPopoverController

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == self.settingPopover) {
        if ([self.settingPopover.contentViewController.childViewControllers[0] isEventSettingChanged]) {
            [self.eventViewController reloadEvents];
        }
        [self setupSettings];
    }
    return YES;
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
@end

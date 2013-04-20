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
#import "SettingViewController.h"
#import "CalendarViewController+Week.h"
#import "EventViewController.h"
#import "CopybleLabel.h"
#import "ViewSheet.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "DateSelect.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CalendarCalcViewController ()<SettingViewControllerDelegate, DateSelect, CalendarViewControllerDelegate, UIPopoverControllerDelegate, EventViewControllerDelegate>
@property(weak, nonatomic) IBOutlet CopybleLabel *display;
@property(weak, nonatomic) IBOutlet UILabel *indicator;
@property(weak, nonatomic) IBOutlet UIButton *decimalButton;
@property(weak, nonatomic) IBOutlet UIButton *dateButton;
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) UIPopoverController *settingPopover;
@property(strong, nonatomic) ViewSheet *currentViewSheet;
@property(strong, nonatomic) CalcValue *result;
@property(weak, nonatomic) AVAudioPlayer *player;
@property(strong, nonatomic) UIPopoverController *currentPopover;

- (void)showEventView:(UIButton *)sender;
- (void)configureView;
- (IBAction)onCalcKey:(UIButton *)sender;
- (IBAction)onDateKey:(UIButton *)sender;
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;
- (void)settingDynamicCalendar;
- (void)dismissContentViewControllerAnimated:(BOOL)animated;
- (void)presentContentViewControllerAnimated:(BOOL)animated fromRect:(CGRect)rect;
@end


@implementation CalendarCalcViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _calcController = [[CalcController alloc] init];
        _calendarViewController = [[CalendarViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.decimalButton setTitle:[NSString decimalSeparator]
                        forState:UIControlStateNormal];
    [self configureView];
    [self.calendarViewController showWeekView];
    [self.calendarViewController setDelegate:self];
    [self.calendarViewController setActionDelegate:self];
    [self.eventViewController setDelegate:self];
    [self settingDynamicCalendar];
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


#pragma mark - IBAction

- (IBAction)onCalcKey:(UIButton *)sender
{
    self.result = [self.calcController inputInteger:sender.tag];
    [self configureView];
}

- (IBAction)onDateKey:(UIButton *)sender
{
    [self showCalendarView];
}

- (IBAction)onSetting:(UIButton *)sender {
    SettingViewController *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController"
                                                                                           bundle:nil];
    [settingViewController setDelegate:self];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [settingViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:settingViewController animated:YES completion:nil];
    } else {
        [self.settingPopover dismissPopoverAnimated:YES];
        self.settingPopover = [[UIPopoverController alloc] initWithContentViewController:settingViewController];
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

- (void)settingDynamicCalendar
{
    [self.calendarViewController setDynamicCalendar:
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption]];
}


#pragma mark - DateSelect

- (void)didSelectDate:(NSDate *)date
{
    [self dismissContentViewControllerAnimated:YES];
    self.result = [self.calcController inputDate:date];
    [self configureView];
}

- (void)didSelectWeek:(Week)week
              exclude:(BOOL)exclude
{
    [self.calcController setWeek:week exclude:exclude];
}

- (void)calendarViewControllerDidCancel:(CalendarViewController *)calendarViewController
{
    [self dismissContentViewControllerAnimated:YES];
}

- (void)calendarViewControllerShouldShowEvent:(CalendarViewController *)viewController
{
    [self showEventView:nil];
}


#pragma mark - SettingViewController

- (void)settingViewControllerDidFinish:(SettingViewController *)viewController
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.settingPopover dismissPopoverAnimated:YES];
    }
    [self settingDynamicCalendar];
}


#pragma mark - EventViewController

- (void)eventViewControllerDidCancel:(EventViewController *)eventViewController
{
    [self dismissContentViewControllerAnimated:YES];
}

- (void)eventViewControllerDidDone:(EventViewController *)eventViewController
{
    [self dismissContentViewControllerAnimated:YES];
    self.result = [self.calcController inputDate:[eventViewController selectedDate]];
    [self configureView];
}


#pragma mark - UIPopoverController

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == self.settingPopover) {
        [self settingDynamicCalendar];
    }
    return YES;
}


#pragma mark - Private

- (void)showEventView:(UIButton *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[EventViewController alloc] init];
        [self.eventViewController setDelegate:self];
    }

    [self dismissContentViewControllerAnimated:YES];
   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.eventViewController];
    } else {
        self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:self.eventViewController];
        self.currentPopover.delegate = self;
    }
    
    [self presentContentViewControllerAnimated:YES fromRect:sender.frame];
}

- (void)configureView
{
    self.display.text = self.result ? [self.result stringValue] : @"0";
    self.indicator.text = [NSString stringWithFunction:[self.calcController currentFunction]];
    [self.clearButton setTitle:[self.calcController isAllCleared] ? @"AC" : @"C"
                      forState:UIControlStateNormal];
}

- (void)showCalendarView
{
    [self dismissContentViewControllerAnimated:YES];
    self.currentViewSheet = [[ViewSheet alloc] initWithContentViewController:self.calendarViewController];
    [self presentContentViewControllerAnimated:YES fromRect:CGRectZero];
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

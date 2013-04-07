//
//  CCCalendarCalcViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+Setting.h"
#import "SettingViewController.h"
#import "CalendarViewController+Week.h"
#import "ViewSheet.h"
#import "CalendarCalc.h"
#import "DateSelect.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CalendarCalcViewController ()<SettingViewControllerDelegate, DateSelect, CalendarViewControllerDelegate>
@property(strong, nonatomic) CalendarCalc *calendarCalc;
@property(weak, nonatomic) IBOutlet UIButton *decimalButton;
@property(strong, nonatomic) UIPopoverController *settingPopover;
@property(strong, nonatomic) ViewSheet *currentViewSheet;

- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onFunction:(UIButton *)sender;
- (IBAction)onNumber:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;
- (void)settingDynamicCalendar;
- (void)dismissContentViewControllerAnimated:(BOOL)animated;
- (void)presentContentViewControllerAnimated:(BOOL)animated fromRect:(CGRect)rect;
@end


@implementation CalendarCalcViewController
static const NSInteger DoubleZero = 10;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _calendarCalc = [[CalendarCalc alloc] init];
        _calendarCalcFormatter = [[CalendarCalcFormatter alloc] initWithCalendarCalc:_calendarCalc];
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
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [self setIndicator:nil];
    [self setClearButton:nil];
    [self setDecimalButton:nil];
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
    
    [self.calendarCalc inputString:string];
    [self configureView];
}


#pragma mark - IBAction

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

- (IBAction)onFunction:(UIButton *)sender
{
    [self.calendarCalc inputFunction:sender.tag];
    [self configureView];
}

- (IBAction)onNumber:(UIButton *)sender
{
    if (sender.tag < DoubleZero) {
        [self.calendarCalc inputInteger:sender.tag];
    } else if (sender.tag == DoubleZero) {
        [self.calendarCalc inputInteger:0];
        [self.calendarCalc inputInteger:0];
    } else {
        NSLog(@"TAG: %d", sender.tag);
        abort();
    }
    [self configureView];
    
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


#pragma mark - DateSelect

- (void)didSelectDate:(NSDate *)date
{
    [self dismissContentViewControllerAnimated:YES];
    [self.calendarCalc inputDate:date];
    [self configureView];
}

- (void)didSelectWeek:(Week)week
              exclude:(BOOL)exclude
{
    [self.calendarCalc setWeek:week exclude:exclude];
}

- (void)calendarViewControllerDidCancel:(CalendarViewController *)calendarViewController
{
    [self dismissContentViewControllerAnimated:YES];
}

- (void)calendarViewControllerShouldShowEvent:(CalendarViewController *)viewController
{
    [self showEventView:nil];
}

#pragma mark - EventViewController

- (void)eventViewControllerDidCancel:(EventViewController *)eventViewController
{
    [self dismissContentViewControllerAnimated:YES];
}

- (void)eventViewControllerDidDone:(EventViewController *)eventViewController
{
    [self dismissContentViewControllerAnimated:YES];
    [self.calendarCalc inputDate:self.eventViewController.selectedDate];
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
    self.display.text = [self.calendarCalcFormatter displayResult];
    self.indicator.text = [self.calendarCalcFormatter displayIndicator];
    [self.clearButton setTitle:[self.calendarCalcFormatter displayClearButtonTitle]
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

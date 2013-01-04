//
//  CCCalendarCalcViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcViewController.h"
#import "CCAppDelegate.h"
#import "CCAppDelegate+Setting.h"
#import "CCSettingViewController.h"
#import "CCCalendarCalc.h"
#import "CCDateSelect.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CCCalendarCalcViewController () <CCSettingViewControllerDelegate, CCDateSelect> {
  @private
    UIPopoverController *_settingPopover;
}

// properties
@property (strong, nonatomic) CCCalendarCalc *calendarCalc;
@property (weak, nonatomic) IBOutlet UIButton *decimalButton;

// methods
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onFunction:(UIButton *)sender;
- (IBAction)onNumber:(UIButton *)sender;

- (IBAction)onClick:(UIButton *)sender;
@end


@implementation CCCalendarCalcViewController

enum {
    CCDoubleZero = 10,
};

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _calendarCalc = [[CCCalendarCalc alloc] init];
        _calendarCalcFormatter = [[CCCalendarCalcFormatter alloc] initWithCalendarCalc:_calendarCalc];
        _calendarViewController = [[CCCalendarViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.decimalButton setTitle:[NSString decimalSeparator]
                        forState:UIControlStateNormal];
    [self configureView];
    self.calendarViewController.delegate = self;
    self.player = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] player];
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
    self.calendarViewController = nil;
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
    CCSettingViewController *settingViewController = [[CCSettingViewController alloc] initWithNibName:@"CCSettingViewController"
                                                                                               bundle:nil];
    [settingViewController setDelegate:self];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [settingViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:settingViewController animated:YES completion:nil];
    } else {
        if ([_settingPopover isPopoverVisible]){
            [_settingPopover dismissPopoverAnimated:YES];
        }
        _settingPopover = [[UIPopoverController alloc] initWithContentViewController:settingViewController];
        [_settingPopover presentPopoverFromRect:sender.frame
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
    if (sender.tag < CCDoubleZero) {
        [self.calendarCalc inputInteger:sender.tag];
    } else if (sender.tag == CCDoubleZero) {
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


#pragma mark - CCSettingViewController

- (void)settingViewControllerDidFinish:(CCSettingViewController *)viewController
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if ([_settingPopover isPopoverVisible]) {
            [_settingPopover dismissPopoverAnimated:YES];
        }
    }
}


#pragma mark - CCDateSelect

- (void)didSelectDate:(NSDate *)date
{
    [self.calendarCalc inputDate:date];
    [self configureView];
}

- (void)didSelectWeek:(ASCWeek)week
              exclude:(BOOL)exclude
{
    [self.calendarCalc setWeek:week exclude:exclude];
}


#pragma mark - Private

- (void)showEventView:(UIButton *)sender
{
    abort();
}

- (void)onEventDone
{
    [self.calendarCalc inputDate:self.eventViewController.selectedDate];
    [self configureView];
}

- (void)configureView
{
    abort();
}

@end

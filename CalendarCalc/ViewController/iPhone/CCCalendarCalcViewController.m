//
//  CCCalendarCalcViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcViewController.h"
#import "CCSettingViewController.h"
#import "CCCalendarCalc.h"
#import "CCDateSelect.h"
#import "CCAppDelegate+Setting.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CCCalendarCalcViewController () <CCSettingViewControllerDelegate, CCDateSelect>

// properties
@property (strong, nonatomic) CCCalendarCalc *calendarCalc;
@property (weak, nonatomic) IBOutlet UIButton *decimalButton;

// methods
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onFunction:(UIButton *)sender;
- (IBAction)onNumber:(UIButton *)sender;

- (IBAction)onClick:(UIButton *)sender;
- (void)onEventDone:(UIBarButtonItem *)sender;
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

        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"key_click"
                                                              ofType:@"aif"];
        NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error: nil];
        [_player setVolume:0.5];
        [_player prepareToPlay];
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
    [settingViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:settingViewController animated:YES completion:nil];
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
    [_player setCurrentTime:0];
    [_player play];
}


#pragma mark - Private

- (void)onEventButton:(UIBarButtonItem *)sender
{
    abort();
}

- (void)onEventDone:(UIBarButtonItem *)sender
{
    [self.calendarCalc inputDate:self.eventViewController.selectedDate];
    [self configureView];
}

- (void)configureView
{
    abort();
}


#pragma mark - CCSettingViewController

- (void)settingViewControllerDidFinish:(CCSettingViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end

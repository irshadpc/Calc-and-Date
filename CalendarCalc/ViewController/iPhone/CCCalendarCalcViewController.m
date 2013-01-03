//
//  CCCalendarCalcViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcViewController.h"
#import "CCCalendarViewController.h"
#import "CCEventViewController.h"
#import "CCSettingViewController.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcFormatter.h"
#import "CCViewSheet.h"
#import "CCDateSelect.h"
#import "CCAppDelegate+Setting.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CCCalendarCalcViewController () <CCSettingViewControllerDelegate, CCDateSelect, CCViewSheetDelegate>

// properties
@property (strong, nonatomic) CCCalendarViewController *calendarViewController;
@property (strong, nonatomic) CCEventViewController *eventViewController;
@property (strong, nonatomic) CCCalendarCalc *calendarCalc;
@property (strong, nonatomic) CCCalendarCalcFormatter *calendarCalcFormatter;

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *indicator;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *decimalButton;

// methods
- (IBAction)onSetting:(UIButton *)sender;
- (IBAction)onFunction:(UIButton *)sender;
- (IBAction)onNumber:(UIButton *)sender;
- (IBAction)onDate:(UIButton *)sender;
- (IBAction)onClick:(UIButton *)sender;
- (void)onEventButton:(UIBarButtonItem *)sender;
- (void)onEventDone:(UIBarButtonItem *)sender;
- (UIBarButtonItem *)eventButton;
- (UIBarButtonItem *)eventDoneButton;
- (void)configureView;
@end


@implementation CCCalendarCalcViewController
@synthesize dateButton = _dateButton;

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
        _eventViewController = [[CCEventViewController alloc] init];

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

    NSDate *date = [NSDate date];
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]]
                     forState:UIControlStateNormal];
    [self.decimalButton setTitle:[NSString decimalSeparator]
                        forState:UIControlStateNormal];
    [self configureView];
    self.calendarViewController.delegate = self;
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [self setIndicator:nil];
    [self setDateButton:nil];
    [self setClearButton:nil];
    [self setDecimalButton:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.calendarViewController = nil;
    self.eventViewController = nil;
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

- (IBAction)onDate:(UIButton *)sender
{
    if (!self.calendarViewController) {
        self.calendarViewController = [[CCCalendarViewController alloc] init];
    }
    
    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }
    
    [self.calendarViewController setDynamicCalendar:
     [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption]];
    _currentViewSheet = [[CCViewSheet alloc] initWithContentViewController:self.calendarViewController];
    _currentViewSheet.delegate = self;
    [_currentViewSheet setRightButton:[self eventButton]];
    [_currentViewSheet showInView:self.view animated:YES];
}

- (IBAction)onClick:(UIButton *)sender
{
    [_player setCurrentTime:0];
    [_player play];
}


#pragma mark - Private

- (void)onEventButton:(UIBarButtonItem *)sender
{
    if (!self.eventViewController) {
        self.eventViewController = [[CCEventViewController alloc] init];
    }
    
    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }
   
    _currentViewSheet = [[CCViewSheet alloc] initWithContentViewController:self.eventViewController];
    _currentViewSheet.delegate = self;
    [_currentViewSheet setRightButton:[self eventDoneButton]];
    [_currentViewSheet showInView:self.view animated:YES];
}

- (void)onEventDone:(UIBarButtonItem *)sender
{
    [self.calendarCalc inputDate:self.eventViewController.selectedDate];
    [self configureView];
    
    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }
}

- (UIBarButtonItem *)eventButton
{
    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"EVENT", nil)
                                            style:UIBarButtonItemStyleBordered
                                           target:self 
                                           action:@selector(onEventButton:)];
}

- (UIBarButtonItem *)eventDoneButton
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(onEventDone:)];
}

- (void)configureView
{
    self.display.text = [self.calendarCalcFormatter displayResult];
    self.indicator.text = [self.calendarCalcFormatter displayIndicator];
    [self.clearButton setTitle:[self.calendarCalcFormatter displayClearButtonTitle]
                      forState:UIControlStateNormal];
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
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]] 
                     forState:UIControlStateNormal];
    if ([_currentViewSheet isVisible]) {
        [_currentViewSheet dismissContainerViewWithAnimated:YES];
    }
}

- (void)didSelectWeek:(ASCWeek)week
              exclude:(BOOL)exclude
{
    [_calendarCalc setWeek:week exclude:exclude];
}


#pragma mark - CCViewSheet

- (void)viewSheetClickedCancelButton:(CCViewSheet *)viewSheet
{
    if ([viewSheet isVisible]) {
        [viewSheet dismissContainerViewWithAnimated:YES];
    }
}

@end

//
//  CCViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCViewController.h"
#import "CCCalendarViewController.h"
#import "CCEventViewController.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcFormatter.h"
#import "CCViewSheet.h"
#import "CCDateSelect.h"
#import "NSDate+Component.h"
#import "NSString+Calculator.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CCViewController () <CCDateSelect, CCViewSheetDelegate>

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


@implementation CCViewController
@synthesize dateButton = _dateButton;

enum {
    CCDoubleZero = 10,
};

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"key_click"
                                                              ofType:@"aif"];
        NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error: nil];
        [_player setVolume:0.5];
        [_player prepareToPlay];

        _calendarCalc = [[CCCalendarCalc alloc] init];
        _calendarCalcFormatter = [[CCCalendarCalcFormatter alloc] initWithCalendarCalc:_calendarCalc];
        _calendarViewController = [[CCCalendarViewController alloc] init];
        _eventViewController = [[CCEventViewController alloc] init];
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
    
    self.calendarViewController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.calendarViewController = nil;
    self.eventViewController = nil;
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

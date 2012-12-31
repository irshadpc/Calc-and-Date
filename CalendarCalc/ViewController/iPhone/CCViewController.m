//
//  CCViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCViewController.h"
#import "CCCalendarViewController.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "CCViewSheet.h"
#import "CCDateSelect.h"
#import "NSDate+Component.h"
#import "NSString+Date.h"
#import "NSString+Locale.h"

@interface CCViewController () <CCDateSelect, CCViewSheetDelegate>

// properties
@property (strong, nonatomic) CCCalendarViewController *calendarViewController;
@property (strong, nonatomic) CCCalendarCalc *calendarCalc;
@property (strong, nonatomic) CCViewSheet *viewSheet;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.calendarViewController = nil;
}

- (IBAction)onFunction:(UIButton *)sender
{
    self.display.text = [[_calendarCalc inputFunction:sender.tag] displayResult];
}

- (IBAction)onNumber:(UIButton *)sender
{
    if (sender.tag < CCDoubleZero) {
        self.display.text = [[_calendarCalc inputInteger:sender.tag] displayResult];
    } else if (sender.tag == CCDoubleZero) {
        [_calendarCalc inputInteger:0];
        self.display.text = [[_calendarCalc inputInteger:0] displayResult];
    } else {
        NSLog(@"TAG: %d", sender.tag);
        abort();
    }
}

- (IBAction)onDate:(UIButton *)sender
{
    if (!self.calendarViewController) {
        self.calendarViewController = [[CCCalendarViewController alloc] init];
        self.calendarViewController.delegate = self;
        self.viewSheet = [[CCViewSheet alloc] initWithContentViewController:self.calendarViewController];
        self.viewSheet.delegate = self;
    }
    [self.viewSheet showInView:self.view animated:YES];
}

- (IBAction)onClick:(UIButton *)sender
{
    [_player setCurrentTime:0];
    [_player play];
}


#pragma mark - CCDateSelect

- (void)didSelectDate:(NSDate *)date
{
    self.display.text = [[self.calendarCalc inputDate:date] displayResult];
    [self.dateButton setTitle:[NSString stringWithYear:[date year] month:[date month]] 
                     forState:UIControlStateNormal];
    [self.viewSheet dismissContainerViewWithAnimated:YES];
}

- (void)didSelectWeek:(ASCWeek)week
              exclude:(BOOL)exclude
{
    [_calendarCalc setWeek:week exclude:exclude];
}

#pragma mark - CCViewSheet

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

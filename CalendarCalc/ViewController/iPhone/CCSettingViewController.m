//
//  CCSettingViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCSettingViewController.h"
#import "CCAppDelegate+Setting.h"

@interface CCSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property (weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
- (IBAction)onIncludeStartDayOptionChanged:(UISwitch *)sender;
- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender;
@end

@implementation CCSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.includeStartDayOption.on = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] includeStartDayOption];
    self.dynamicCalendarOption.on = [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] dynamicCalendarOption];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onIncludeStartDayOptionChanged:(UISwitch *)sender {
    [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] setIncludeStartDayOption:sender.isOn];
}

- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender {
    [(CCAppDelegate *)[[UIApplication sharedApplication] delegate] setDynamicCalendarOption:sender.isOn];
}
- (void)viewDidUnload {
    [self setIncludeStartDayOption:nil];
    [self setDynamicCalendarOption:nil];
    [super viewDidUnload];
}
@end

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
    // Do any additional setup after loading the view from its nib.
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
@end

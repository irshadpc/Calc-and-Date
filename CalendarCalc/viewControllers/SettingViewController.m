//
//  CCSettingViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "SettingViewController.h"
#import "EventSettingViewController.h"
#import "ViewSheet.h"
#import "AppDelegate+Setting.h"

@interface SettingViewController ()
@property(weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property(weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
@property(weak, nonatomic) IBOutlet UIView *lastOptionItem;
@property(strong, nonatomic) EventSettingViewController *eventSettingViewController;

- (void)onDone:(UIBarButtonItem *)sender;
- (void)onCancel:(UIBarButtonItem *)sender;
- (IBAction)onCalendarSettings:(UIButton *)sender;
@end

@implementation SettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.includeStartDayOption.on = [appDelegate includeStartDayOption];
    self.dynamicCalendarOption.on = [appDelegate dynamicCalendarOption];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect lastOptionItemFrame = self.lastOptionItem.frame;
        self.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width,
                                                      lastOptionItemFrame.origin.y +
                                                      lastOptionItemFrame.size.height + 44.0 - 20.0);
    } else {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                target:self
                                                                                                action:@selector(onCancel:)]];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                 target:self
                                                                                                 action:@selector(onDone:)]];
    }

    self.eventSettingViewController = [[EventSettingViewController alloc] initWithNibName:@"EventSettingViewController"
                                                                                   bundle:nil];
    [self.eventSettingViewController setDisabledCalendars:[appDelegate disabledCalendars]];
    [self.eventSettingViewController setEnabledEventColor:[appDelegate eventColorOption]];
}

- (void)viewDidUnload {
    [self setIncludeStartDayOption:nil];
    [self setDynamicCalendarOption:nil];
    [self setLastOptionItem:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.eventSettingViewController isViewLoaded]) {
        [self.popover setPopoverContentSize:self.contentSizeForViewInPopover animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveSettings
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setIncludeStartDayOption:self.includeStartDayOption.isOn];
    [appDelegate setDynamicCalendarOption:self.dynamicCalendarOption.isOn];
    [appDelegate setEventColorOption:[self.eventSettingViewController isEnabledEventColor]];
    if ([self.eventSettingViewController isChanged]) {
        [appDelegate setDisabledCalendars:[self.eventSettingViewController disabledCalendars]];
        [self.delegate settingViewControllerDidChangedCalendarSetting:self];
    }
}

- (void)onDone:(UIBarButtonItem *)sender {
    [self saveSettings];
    [self.delegate settingViewControllerDidFinish:self];
}

- (void)onCancel:(UIBarButtonItem *)sender {
    [self.delegate settingViewControllerDidFinish:self];
}

- (IBAction)onCalendarSettings:(UIButton *)sender
{
    [self.navigationController pushViewController:self.eventSettingViewController
                                         animated:YES];
}
@end

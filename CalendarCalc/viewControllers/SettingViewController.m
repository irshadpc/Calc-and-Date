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
#import "UIBarButtonItem+AdditionalConvenienceConstructor.h"
#import "UIViewController+PopoverSupport.h"

@interface SettingViewController ()
@property(weak, nonatomic) IBOutlet UISwitch *includeStartDayOption;
@property(weak, nonatomic) IBOutlet UISwitch *dynamicCalendarOption;
@property(weak, nonatomic) IBOutlet UILabel *eventSettingLabel;
@property(weak, nonatomic) IBOutlet UIView *lastOptionItem;
@property(strong, nonatomic) EventSettingViewController *eventSettingViewController;

- (void)onClose:(UIBarButtonItem *)sender;
- (IBAction)onIncludeStartDateOptionChanged:(UISwitch *)sender;
- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender;
- (IBAction)onEventSettings:(UIButton *)sender;
- (IBAction)onEnterEventSettingNavigation:(UIButton *)sender;
- (IBAction)onExitEventSettingNavigation:(UIButton *)sender;
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
        [self setContentSizeForPopover:CGSizeMake(self.view.frame.size.width,
                                                  lastOptionItemFrame.origin.y + lastOptionItemFrame.size.height + 44.0 - 20.0)];
    } else {
        [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem closeButtonItemWithTarget:self
                                                                                      action:@selector(onClose:)]];
    }
    [self setTitle:NSLocalizedString(@"SETTINGS", nil)];
    self.eventSettingViewController = [[EventSettingViewController alloc] initWithNibName:@"EventSettingViewController"
                                                                                   bundle:nil];
}

- (void)viewDidUnload {
    [self setIncludeStartDayOption:nil];
    [self setDynamicCalendarOption:nil];
    [self setLastOptionItem:nil];
    [self setEventSettingLabel:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.eventSettingViewController isViewLoaded]) {
        [self.popover setPopoverContentSize:[self contentSizeForPopover] animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isEventSettingChanged
{
    return self.eventSettingViewController.isChanged;
}


#pragma mark - Action

- (void)onClose:(UIBarButtonItem *)sender {
    [self.delegate settingViewControllerDidFinish:self];
}

- (IBAction)onIncludeStartDateOptionChanged:(UISwitch *)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setIncludeStartDayOption:sender.isOn];
}

- (IBAction)onDynamicCalendarOptionChanged:(UISwitch *)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setDynamicCalendarOption:sender.isOn];
}

- (IBAction)onEventSettings:(UIButton *)sender
{
    [self.navigationController pushViewController:self.eventSettingViewController
                                         animated:YES];
    [self onExitEventSettingNavigation:sender];
}

- (IBAction)onEnterEventSettingNavigation:(UIButton *)sender
{
    [self.eventSettingLabel setHighlighted:YES];
}

- (IBAction)onExitEventSettingNavigation:(UIButton *)sender
{
    [self.eventSettingLabel setHighlighted:NO];
}
@end

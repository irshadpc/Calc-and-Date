//
//  CalendarSelectViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "EventSettingViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+Setting.h"
#import "UIView+MutableFrame.h"
#import "EKEventStore+Event.h"

@interface EventSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) UISwitch *eventColorSettingSwitch;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) EKEventStore *eventStore;
@property(nonatomic, getter=isGranted) BOOL granted;
@property(strong, nonatomic) NSMutableArray *disabledCalendars;
@property(strong, nonatomic) NSArray *calendars;
@property(nonatomic, getter=isChanged, readwrite) BOOL changed;

- (void)onEventColorSettingChanged:(UISwitch *)sender;
- (UITableViewCell *)eventCalendarSettingCellWithTableView:(UITableView *)tableView atRow:(NSInteger)row;
- (UITableViewCell *)eventColorSettingCellWithTableView:(UITableView *)tableView;
- (void)reloadTableData;
@end

@implementation EventSettingViewController
typedef enum {
    SectionEventCalendars,
    SectionEventColor,

    SectionMax
} Section;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _eventStore = [[EKEventStore alloc] init];
        [_eventStore requestAccessToEventWithCompletion:^(BOOL granted, NSError *error) {
            _granted = granted;
            [self reloadTableData];
        }];

        _eventColorSettingSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [_eventColorSettingSwitch addTarget:self
                                     action:@selector(onEventColorSettingChanged:)
                           forControlEvents:UIControlEventValueChanged];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_indicatorView setColor:[UIColor darkGrayColor]];
        [_indicatorView setHidesWhenStopped:YES];

        self.title = NSLocalizedString(@"EVENT_SETTINGS", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.disabledCalendars = [[appDelegate disabledCalendars] mutableCopy];
    if (!self.disabledCalendars) {
        self.disabledCalendars = [NSMutableArray array];
    }
    
    [self.eventColorSettingSwitch setOn:[appDelegate eventColorOption]];
   
    if (self.isGranted && self.calendars) {
        [self.tableView reloadData];
    } 
    if (!self.calendars) {
        self.indicatorView.center = self.tableView.center;
        [self.indicatorView startAnimating];
        [self.tableView addSubview:self.indicatorView];
    }

    self.contentSizeForViewInPopover = self.tableView.bounds.size;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return SectionMax;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SectionEventCalendars) {
        return [self.calendars count];
    } else if (section == SectionEventColor) {
        return 1;
    } else {
        NSLog(@"SECTION: %d", section);
        abort();
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == SectionEventColor) {
        return nil;
    }
    return NSLocalizedString(@"ENABLED_CALNEDARS", nil);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == SectionEventColor) {
        return nil;
    }

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:[self tableView:tableView titleForHeaderInSection:section]];
    [label setTextColor:[UIColor whiteColor]];
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0]];
    [label sizeToFit];
    [label setFrameOriginX:10.0];
    [label setFrameOriginY:6.0];
    
    UIView *view = [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    [view addSubview:label];

    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == SectionEventCalendars) {
        return nil;
    }
    return NSLocalizedString(@"CALENDAR_COLOR_EXPLAIN", nil);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == SectionEventCalendars) {
        return nil;
    }
    
    const CGFloat Margin =  16.0;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:[self tableView:tableView titleForFooterInSection:section]];
    [label setTextColor:[UIColor lightTextColor]];
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:14.0]];
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setFrameSizeWidth:self.view.bounds.size.width - (Margin * 2)];
    [label setFrameOrigin:CGPointMake(Margin, 2.0)];
    [label sizeToFit];

    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:label];

    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SectionEventCalendars) {
        return [self eventCalendarSettingCellWithTableView:tableView atRow:indexPath.row];
    } else if (indexPath.section == SectionEventColor) {
        return [self eventColorSettingCellWithTableView:tableView];
    } else {
        NSLog(@"SECTION: %d", indexPath.section);
        abort();
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == SectionEventColor) {
        return;
    }

    EKCalendar *calendar = [self.calendars objectAtIndex:indexPath.row];    
    if ([self.disabledCalendars containsObject:[calendar calendarIdentifier]]) {
        [self.disabledCalendars removeObject:[calendar calendarIdentifier]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [self.disabledCalendars addObject:[calendar calendarIdentifier]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setDisabledCalendars:self.disabledCalendars];

    self.changed = YES;
}


#pragma mark - Action

- (void)onEventColorSettingChanged:(UISwitch *)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setEventColorOption:sender.isOn];
    self.changed = YES;
}


#pragma mark - Private

- (void)reloadTableData
{
    [self.indicatorView stopAnimating];

    if (!self.isGranted) {
        return;
    }

    self.calendars = [self.eventStore eventCalendars];
    [self.tableView reloadData];
}

- (UITableViewCell *)eventCalendarSettingCellWithTableView:(UITableView *)tableView atRow:(NSInteger)row
{
    static NSString *CalendarCellIdentifier = @"CalendarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CalendarCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CalendarCellIdentifier];
    }

    EKCalendar *calendar = self.calendars[row];
    [cell.textLabel setText:[calendar title]];
    [cell.textLabel setTextColor:[UIColor colorWithCGColor:[calendar CGColor]]];

    if ([self.disabledCalendars containsObject:[calendar calendarIdentifier]]) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
}

- (UITableViewCell *)eventColorSettingCellWithTableView:(UITableView *)tableView
{
    static NSString *EventColorSettingCellIdentifier = @"EventColorSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventColorSettingCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:EventColorSettingCellIdentifier];
        [cell.textLabel setText:NSLocalizedString(@"USE_CALENDAR_COLORS", nil)];
        self.eventColorSettingSwitch.center = cell.contentView.center;
        CGFloat originX = cell.contentView.bounds.size.width - self.eventColorSettingSwitch.bounds.size.width - 20.0;
        [self.eventColorSettingSwitch setFrameOriginX:originX];
        [cell.contentView addSubview:self.eventColorSettingSwitch];
    }
    return cell;
}
@end

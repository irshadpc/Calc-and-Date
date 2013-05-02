//
//  CalendarSelectViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "EventSettingViewController.h"
#import "UIView+MutableFrame.h"

@interface EventSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) UISwitch *eventColorSettingSwitch;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) EKEventStore *eventStore;
@property(nonatomic, getter=isGranted) BOOL granted;
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
        if ([_eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
            [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                _granted = granted;
                [self reloadTableData];
            }];
        } else {
            _granted = YES;
            [self reloadTableData];
        }

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

    if (self.isGranted && self.calendars) {
        [self.tableView reloadData];
    } 
    if (!self.calendars) {
        self.indicatorView.center = self.tableView.center;
        [self.indicatorView startAnimating];
        [self.tableView addSubview:self.indicatorView];
    }   
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
    if (section == SectionEventCalendars) {
        return @"使用カレンダー";
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:[self tableView:tableView titleForHeaderInSection:section]];
    [label setTextColor:[UIColor whiteColor]];
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0]];
    [label sizeToFit];
    [label setFrameOriginX:10.0];
    [label setFrameOriginY:6.0];
    
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
    NSMutableArray *disabledCalendars = [self.disabledCalendars mutableCopy];
    if (!disabledCalendars) {
        disabledCalendars = [NSMutableArray array];
    }
    
    if ([disabledCalendars containsObject:[calendar calendarIdentifier]]) {
        [disabledCalendars removeObject:[calendar calendarIdentifier]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [disabledCalendars addObject:[calendar calendarIdentifier]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }

    self.disabledCalendars = disabledCalendars;
    self.changed = YES;
}


#pragma mark - Action

- (void)onEventColorSettingChanged:(UISwitch *)sender
{
    self.enabledEventColor = [sender isOn];
}


#pragma mark - Private

- (void)reloadTableData
{
    [self.indicatorView stopAnimating];

    if (!self.isGranted) {
        return;
    }

    if ([self.eventStore respondsToSelector:@selector(calendarsForEntityType:)]) {
        self.calendars = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    } else {
        self.calendars = [self.eventStore calendars];
    }
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
        [cell.textLabel setText:@"イベントカラー"];
        self.eventColorSettingSwitch.center = cell.contentView.center;
        CGFloat originX = cell.contentView.bounds.size.width - self.eventColorSettingSwitch.bounds.size.width - 20.0;
        [self.eventColorSettingSwitch setFrameOriginX:originX];
        [self.eventColorSettingSwitch setOn:self.enabledEventColor];
        [cell.contentView addSubview:self.eventColorSettingSwitch];
    }
    return cell;
}
@end
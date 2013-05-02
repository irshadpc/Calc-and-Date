//
//  CalendarSelectViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarSelectViewController.h"

@interface CalendarSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) EKEventStore *eventStore;
@property(nonatomic, getter=isGranted) BOOL granted;
@property(strong, nonatomic) NSArray *calendars;
@property(nonatomic, getter=isChanged, readwrite) BOOL changed;

- (void)reloadTableData;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation CalendarSelectViewController
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
       
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_indicatorView setColor:[UIColor darkGrayColor]];
        [_indicatorView setHidesWhenStopped:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.calendars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CalendarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EKCalendar *calendar = [self.calendars objectAtIndex:indexPath.row];
    NSMutableArray *disabledCalendars = [self.disabledCalendars mutableCopy];
    if ([disabledCalendars containsObject:[calendar calendarIdentifier]]) {
        [disabledCalendars removeObject:[calendar calendarIdentifier]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [disabledCalendars addObject:[calendar calendarIdentifier]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }

    self.disabledCalendars = disabledCalendars;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.changed = YES;
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    EKCalendar *calendar = self.calendars[indexPath.row];
    [cell.textLabel setText:[calendar title]];
    [cell.textLabel setTextColor:[UIColor colorWithCGColor:[calendar CGColor]]];
   
    if ([self.disabledCalendars containsObject:[calendar calendarIdentifier]]) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}
@end

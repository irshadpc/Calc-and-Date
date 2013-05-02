//
//  CCEventViewController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "EventViewController.h"
#import "EventCell.h"
#import "EventManager.h"
#import "NSArray+safe.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"
#import "NSString+Locale.h"
#import "UIBarButtonItem+AdditionalConvenienceConstructor.h"
#import "UIView+MutableFrame.h"

@interface NSDictionary (Sort)
- (NSArray *)sortedKeys;
@end

@implementation NSDictionary (Sort)
- (NSArray *)sortedKeys
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(compare:)];
}
@end


@interface UISearchBar (UI)
- (void)setEnabledCancelButton:(BOOL)enabled;
@end

@implementation UISearchBar (UI)
- (void)setEnabledCancelButton:(BOOL)enabled
{
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setEnabled:enabled];
            break;
        }
    }
}
@end

@interface EventViewController ()<EventManagerDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) EventManager *eventManager;
@property(strong, nonatomic) NSDictionary *filteredEvents;
@property(strong, nonatomic) NSIndexPath *selectedIndexPath;
@property(strong, nonatomic) NSPredicate *eventTitleFilterTemplate;

- (IBAction)onCancel:(UIBarButtonItem *)sender;
- (IBAction)onTop:(UIButton *)sender;
- (void)reloadTableDataWithFilterText:(NSString *)filterText;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation EventViewController {
    BOOL _isInit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _indicatorView.color = [UIColor grayColor];
        [_indicatorView startAnimating];
        _indicatorView.hidden = NO;
        
        _eventManager = [[EventManager alloc] initWithDelegate:self];
        _isInit = YES;
        _eventTitleFilterTemplate = [NSPredicate predicateWithFormat:@"title contains[cd] $title"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setUserInteractionEnabled:NO];
    [self.tableView addSubview:self.indicatorView];
    [self setContentSizeForViewInPopover:self.view.bounds.size];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.indicatorView setCenter:self.view.center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setEnabledEventColor:(BOOL)enabledEventColor
{
    _enabledEventColor = enabledEventColor;
    [self.tableView reloadData];
}

- (void)reloadEvents
{
    [self.eventManager reloadEvents];
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.filteredEvents count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.filteredEvents sortedKeys][section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.filteredEvents sortedKeys][section];
    return [[self.filteredEvents valueForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [cell.textLabel setTextColor:[UIColor darkTextColor]];
        [cell.detailTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [cell.detailTextLabel setTextColor:[UIColor darkTextColor]];
    }
    if ([indexPath isEqual:self.selectedIndexPath]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *key = [self.filteredEvents sortedKeys][indexPath.section];
    EKEvent *event = [[self.filteredEvents objectForKey:key] objectAtIndex:indexPath.row];
    self.selectedDate =  [event startDate];
    [self.delegate eventViewControllerDidDone:self];
}


#pragma mark - SearchBar

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    [self reloadTableDataWithFilterText:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setText:nil];
    [searchBar resignFirstResponder];
    [searchBar setEnabledCancelButton:YES];
    [self searchBar:searchBar textDidChange:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setEnabledCancelButton:YES];
    [self reloadTableDataWithFilterText:[searchBar text]];
}


#pragma mark - EventManager

- (void)startEventLoad:(EventManager *)eventManager
{
    [self.tableView reloadData];
    [self.indicatorView startAnimating];
    [self.indicatorView setHidden:NO];
}

- (void)completeEventLoad:(EventManager *)eventManager
                  granted:(BOOL)granted
{
    [self reloadTableDataWithFilterText:self.searchBar.text];
    [self.tableView reloadData];
    
    if (_isInit) {
        NSInteger section = 0;
        NSInteger row = NSNotFound;
        for (NSString *key in [self.filteredEvents sortedKeys]) {
            row = [[self.filteredEvents objectForKey:key] indexOfObject:self.eventManager.todayEvent];
            if (row != NSNotFound) {
                break;
            }
            section++;
        }
        if (row != NSNotFound) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]
                                  atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
        _isInit = NO;
    }
    
    [self.indicatorView setHidden:YES];
    [self.indicatorView stopAnimating];
    [self.tableView setUserInteractionEnabled:YES];
}


#pragma mark - Action

- (IBAction)onCancel:(UIBarButtonItem *)sender
{
     [self.delegate eventViewControllerDidCancel:self];
}

- (IBAction)onTop:(UIButton *)sender
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)reloadTableDataWithFilterText:(NSString *)filterText
{
    NSArray *filteredEvents = nil;
    if (!filterText || [filterText length] == 0) {
        filteredEvents = self.eventManager.events;
    } else {
        NSPredicate *predicate = [self.eventTitleFilterTemplate predicateWithSubstitutionVariables:@{@"title" : filterText}];
        filteredEvents = [self.eventManager.events filteredArrayUsingPredicate:predicate];
    }
   
    NSInteger oldYear = 0;
    NSMutableDictionary *sectioningEvents = [NSMutableDictionary dictionary];
    NSMutableArray *events = nil;
    for (EKEvent *event in filteredEvents) {
        NSInteger year = [[event startDate] year];

        if (year != oldYear) {
            if (events) {
                [sectioningEvents setObject:events forKey:[NSString stringWithFormat:@"%d", oldYear]];
            }
            oldYear = year;
            events = [NSMutableArray array];
        }
        [events addObject:event];
    }
    if ([events count] > 0) {
        [sectioningEvents setObject:events forKey:[NSString stringWithFormat:@"%d", oldYear]];
    }

    self.filteredEvents = sectioningEvents;
    [self.tableView reloadData];
}

- (void)configureCell:(EventCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.filteredEvents sortedKeys][indexPath.section];
    EKEvent *event = [[self.filteredEvents objectForKey:key] objectAtIndex:indexPath.row];
    NSDate *date = [event.startDate noTime];
    NSString *text = [NSString stringWithFormat:@"%d%@%02d%@%02d",
                      [date year],
                      [NSString dateSeparator],
                      [date month],
                      [NSString dateSeparator],
                      [date day]];

    [cell.dateLabel setText:text];
    [cell.titleLabel setText:[event title]];

    if (self.isEnabledEventColor) {
        [cell.titleLabel setTextColor:[UIColor colorWithCGColor:[[event calendar] CGColor]]];
    } else {
        [cell.titleLabel setTextColor:[UIColor darkTextColor]];
    }
}
@end

//
//  DatePickerController.m
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/10.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "DatePickerController.h"
#import "NSArray+Safe.h"
#import "NSDate+ConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIBarButtonItem+ConvenienceConstructor.h"

@interface DatePickerController ()
@property(weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property(weak, nonatomic) IBOutlet UIPickerView *picker;
@property(strong, nonatomic) NSArray *years;
@property(strong, nonatomic) NSArray *months;
@property(strong, nonatomic) NSArray *days;

- (void)onCancel:(UIBarButtonItem *)sender;
- (void)onDone:(UIBarButtonItem *)sender;
- (void)setupYearComponent;
- (void)setupMonthComponent;
- (void)setupDayComponent;
@end

@implementation DatePickerController
@synthesize year = _year;
@synthesize month = _month;
@synthesize day = _day;

static const NSInteger MIN_YEAR = 1900;
static const NSInteger MAX_YEAR = 2200;


- (void)viewDidLoad
{
    [super viewDidLoad];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.toolbar setItems:@[[UIBarButtonItem cancelButtonItemWithTarget:self action:@selector(onCancel:)],
                                 [UIBarButtonItem flexibleSpaceItem],
                                 [UIBarButtonItem doneButtonItemWithTarget:self action:@selector(onDone:)]]];
    } else {
        [self.toolbar setItems:@[[UIBarButtonItem flexibleSpaceItem],
                                 [UIBarButtonItem doneButtonItemWithTarget:self action:@selector(onDone:)]]];
    }
    [self setPreferredContentSize:self.view.bounds.size];

    [self setupYearComponent];
    [self setupMonthComponent];
    [self setupDayComponent];
}

- (void)viewDidUnload {
    [self setPicker:nil];
    [self setToolbar:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.isHideDayComponent ? 2 : 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{    
    if (component == 0) {
        return [self.years count];
    } else if (component == 1) {
        return [self.months count];
    } else {
        return [self.days count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.years[row];
    } else if (component == 1) {
        return self.months[row];
    } else {
        return self.days[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            self.year = [self.years[row] integerValue];
            break;
        case 1:
            self.month = [self.months[row] integerValue];
            break;
        case 2:
            self.day = [self.days[row] integerValue];
            break;
        default:
            NSLog(@"COMPONENT: %ld", (long)component);
            abort();
    }

    if (!self.isHideDayComponent && component != 2) {
        [self setDays:nil];
        [self.picker reloadComponent:2];
    }
}


#pragma mark - Properties

- (void)setYear:(NSInteger)year
{
    _year = year;
    [self setupYearComponent];
}

- (void)setMonth:(NSInteger)month
{
    _month = month;
    [self setupMonthComponent];
}

- (NSInteger)day
{
    if (self.isHideDayComponent) {
        return 1;
    } else {
        return _day;
    }
}

- (void)setDay:(NSInteger)day
{
    if (self.isHideDayComponent) {
        return;
    }
    
    _day = day;
    [self setupDayComponent];
}


#pragma mark - Action

- (void)onCancel:(UIBarButtonItem *)sender {
    [self.delegate datePickerControllerDidCancel:self];
}

- (void)onDone:(UIBarButtonItem *)sender {
    [self.delegate datePickerControllerDidDone:self year:[self year] month:[self month] day:[self day]];
}


#pragma mark - Private

- (void)setupYearComponent
{
    NSInteger yearIndex = [[self years] indexOfObject:[NSString stringWithFormat:@"%ld", (long)_year]];
    if (yearIndex != NSNotFound) {
        [self.picker selectRow:yearIndex
                   inComponent:0
                      animated:NO];
    }
}

- (void)setupMonthComponent
{
    NSInteger monthIndex = [[self months] indexOfObject:[NSString stringWithFormat:@"%02ld", (long)_month]];
    if (monthIndex != NSNotFound) {
        [self.picker selectRow:monthIndex
                   inComponent:1
                      animated:NO];
    }
}

- (void)setupDayComponent
{
    if (self.isHideDayComponent) {
        return;
    }
    
    NSInteger dayIndex = [[self days] indexOfObject:[NSString stringWithFormat:@"%02ld", (long)_day]];
    if (dayIndex != NSNotFound) {
        [self.picker selectRow:dayIndex
                   inComponent:2
                      animated:NO];
    }
}

- (NSArray *)years
{
    if (_years) {
        return _years;
    }

    NSMutableArray *years = [[NSMutableArray alloc] initWithCapacity:MAX_YEAR - MIN_YEAR];
    for (NSInteger year = MIN_YEAR; year <= MAX_YEAR; year++) {
        [years addObject:[[NSString alloc] initWithFormat:@"%ld", (long)year]];
    }
    _years = years;

    return _years;
}

- (NSArray *)months
{
    if (_months) {
        return _months;
    }

    NSMutableArray *months = [[NSMutableArray alloc] initWithCapacity:12];
    for (NSInteger month = 1; month <= 12; month++) {
        [months addObject:[[NSString alloc] initWithFormat:@"%02ld", (long)month]];
    }
    _months = months;
   
    return _months;
}

- (NSArray *)days
{
    if (self.isHideDayComponent) {
        return nil;
    }

    if (_days) {
        return _days;
    }
    NSInteger lastDay = [[NSDate dateWithYear:_year month:_month + 1 day:0] day];
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:lastDay];
    for (NSInteger day = 1; day <= lastDay; day++) {
        [days addObject:[[NSString alloc] initWithFormat:@"%02ld", (long)day]];
    }
    _days = days;

    return _days;
}
@end

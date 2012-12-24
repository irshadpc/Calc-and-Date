//
//  CCYearMonthPickerController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCYearMonthPickerController.h"

@interface CCYearMonthPickerController ()
@property (strong, nonatomic) UIPickerView *pickerView;

- (NSArray *)years;
- (NSArray *)months;
@end

@implementation CCYearMonthPickerController

static const NSInteger MIN_YEAR = 1900;
static const NSInteger MAX_YEAR = 2200;

- (id)init
{
    if ((self = [super init])) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.showsSelectionIndicator = YES;
        [self.view addSubview:_pickerView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = self.pickerView.frame;

    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setYear:(NSInteger)year
{
    _year = year;
    NSInteger yearIndex = [[self years] indexOfObject:[NSString stringWithFormat:@"%d", self.year]];
    if (yearIndex != NSNotFound) {
        [self.pickerView selectRow:yearIndex
                       inComponent:0
                          animated:NO];
    }
}

- (void)setMonth:(NSInteger)month
{
    _month = month;
    NSInteger monthIndex = [[self months] indexOfObject:[NSString stringWithFormat:@"%02d", self.month]];
    if (monthIndex != NSNotFound) {
        [self.pickerView selectRow:monthIndex
                       inComponent:1
                          animated:NO];
    }
}

#pragma mark - Private

- (NSArray *)years
{
    static NSMutableArray *years = nil;
    if (years) {
        return years;
    }
   
    years = [[NSMutableArray alloc] init];
    for (NSInteger year = MIN_YEAR; year <= MAX_YEAR; year++) {
        [years addObject:[[NSString alloc] initWithFormat:@"%d", year]];
    }
    return years;
}

- (NSArray *)months
{
    static NSMutableArray *months = nil;
    if (months) {
        return months;
    }
   
    months = [[NSMutableArray alloc] init];
    for (NSInteger month = 1; month <= 12; month++) {
        [months addObject:[[NSString alloc] initWithFormat:@"%02d", month]];
    }
    return months;
}


#pragma UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.years.count;
    } else {
        return self.months.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.years[row];
    } else {
        return self.months[row];
    }
}

@end

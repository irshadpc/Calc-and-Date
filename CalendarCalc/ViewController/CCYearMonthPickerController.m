//
//  CCYearMonthPickerController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCYearMonthPickerController.h"
#import "NSArray+safe.h"

@interface CCYearMonthPickerController ()
@property (strong, nonatomic) UIPickerView *pickerView;

- (NSArray *)years;
- (NSArray *)months;
- (UIToolbar *)toolbar;
- (CGRect)viewFrame;
- (void)onDone:(UIBarButtonItem *)sender;
@end

@implementation CCYearMonthPickerController
@synthesize year = _year;
@synthesize month = _month;

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

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIToolbar *toolbar = [self toolbar];
        [self.view addSubview:toolbar];

        CGRect pickerFrame = self.pickerView.frame;
        pickerFrame.origin.y += toolbar.frame.size.height;
        self.pickerView.frame = pickerFrame;
    }
    
    self.view.frame = [self viewFrame];
    self.contentSizeForViewInPopover = self.view.frame.size;

    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)year
{
    NSString *year = [[self years] safeObjectAtIndex:[self.pickerView selectedRowInComponent:0]];
    if (year) {
        _year = year.integerValue;
    }
    return _year;
}

- (void)setYear:(NSInteger)year
{
    _year = year;
    NSInteger yearIndex = [[self years] indexOfObject:[NSString stringWithFormat:@"%d", _year]];
    if (yearIndex != NSNotFound) {
        [self.pickerView selectRow:yearIndex
                       inComponent:0
                          animated:NO];
    }
}

- (NSInteger)month
{
    NSString *month = [[self months] safeObjectAtIndex:[self.pickerView selectedRowInComponent:1]];
    if (month) {
        _month = month.integerValue;
    }
    return _month;
}

- (void)setMonth:(NSInteger)month
{
    _month = month;
    NSInteger monthIndex = [[self months] indexOfObject:[NSString stringWithFormat:@"%02d", _month]];
    if (monthIndex != NSNotFound) {
        [self.pickerView selectRow:monthIndex
                       inComponent:1
                          animated:NO];
    }
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

- (UIToolbar *)toolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     self.pickerView.frame.size.width,
                                                                     44.0)];
    [toolbar setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                      target:nil
                                                                      action:nil],
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                      target:self
                                                                      action:@selector(onDone:)]]];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    return toolbar;
}

- (CGRect)viewFrame
{
    return CGRectMake(0,
                      0,
                      self.pickerView.frame.size.width,
                      self.pickerView.frame.origin.y + self.pickerView.frame.size.height);
}

- (void)onDone:(UIBarButtonItem *)sender
{
    [self.delegate yearMonthPickearControllerDidDone:self];
}

@end

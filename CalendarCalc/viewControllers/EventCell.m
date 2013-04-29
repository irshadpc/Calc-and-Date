//
//  EventCell.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "EventCell.h"
#import "UILabel+font.h"

@interface EventCell ()
@property(strong, nonatomic, readwrite) UILabel *dateLabel;
@property(strong, nonatomic, readwrite) UILabel *titleLabel;

+ (UILabel *)commonLabelWithFrame:(CGRect)frame;
@end

@implementation EventCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        _dateLabel = [EventCell commonLabelWithFrame:CGRectMake(8.0, 11.0, 90.0, 21.0)];
        [_dateLabel setTextColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:_dateLabel];

        _titleLabel = [EventCell commonLabelWithFrame:CGRectMake(90.0, 11.0, 200.0, 21.0)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

+ (UILabel *)commonLabelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:14.0]];
    [label setMinimumScale:0.8 orSize:14.0];
    [label setTextColor:[UIColor darkTextColor]];
    [label setHighlightedTextColor:[UIColor whiteColor]];
    [label setAdjustsFontSizeToFitWidth:YES];
    
    return label;
}
@end
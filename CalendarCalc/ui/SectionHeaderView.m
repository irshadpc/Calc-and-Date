//
//  SectionHeaderView.m
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView ()
@property(strong, nonatomic) UILabel *title;

- (CGRect)titleFrame;
@end

@implementation SectionHeaderView
+ (SectionHeaderView *)sectionHeaderWithTitle:(NSString *)title
{
    SectionHeaderView *sectionHeader = [[SectionHeaderView alloc] initWithFrame:CGRectZero];
    [sectionHeader.title setText:title];
   
    return sectionHeader;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 298, 22)]) {
        [self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"section_header"]]];

        _title = [[UILabel alloc] initWithFrame:[self titleFrame]];
        [_title setFont:[UIFont boldSystemFontOfSize:17.]];
        [_title setTextColor:[UIColor whiteColor]];
        [_title setShadowOffset:CGSizeMake(1., 1.)];
        [_title setShadowColor:[UIColor darkTextColor]];
        [_title setTextAlignment:NSTextAlignmentLeft];
        [_title setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_title];
    }
    return self;
}


#pragma mark - Private

- (CGRect)titleFrame
{
    return CGRectMake(8, 2, 304, 20);
}
@end

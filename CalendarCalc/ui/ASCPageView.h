//
//  ASCPageView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/18.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCPageView : UIView <UIScrollViewDelegate>
@property (strong, nonatomic) UIView *headerView;

- (id)initWithContentView:(UIView *)contentView;
- (void)addContentView:(UIView *)contentView;
@end

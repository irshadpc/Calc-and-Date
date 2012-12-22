//
//  ASCPageView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/18.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASCPageViewDelegate;

@interface ASCPageView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) id <ASCPageViewDelegate> delegate;
@property (strong, nonatomic) UIView *headerView;
@property (nonatomic, getter = isInfinitePage) BOOL infinitePage;

- (id)initWithContentView:(UIView *)contentView;
- (void)addContentView:(UIView *)contentView;
- (void)setPage:(NSUInteger)page animated:(BOOL)animated;
@end

@protocol ASCPageViewDelegate <NSObject>
@optional
- (void)pageViewDidPrevPage:(ASCPageView *)pageView;
- (void)pageViewDidNextPage:(ASCPageView *)pageView;

@end
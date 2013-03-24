//
//  ASCPageView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/18.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageViewDelegate;

@interface PageView : UIView <UIScrollViewDelegate> {
  @private
    NSInteger _currentPage;
}

@property (weak, nonatomic) id <PageViewDelegate> delegate;
@property (nonatomic, getter = isPagingEnabled) BOOL pagingEnabled;
- (id)initWithContentView:(UIView *)contentView prevPage:(UIView *)prevView nextPage:(UIView *)nextView;
- (void)setPage:(NSUInteger)page animated:(BOOL)animated;
@end

@protocol PageViewDelegate <NSObject>
@optional
- (void)pageViewDidPrevPage:(PageView *)pageView;
- (void)pageViewDidNextPage:(PageView *)pageView;

@end
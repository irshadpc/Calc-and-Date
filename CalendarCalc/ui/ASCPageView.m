//
//  ASCPageView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/18.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCPageView.h"

@interface ASCPageView ()
@property (strong, nonatomic) NSMutableArray *contentViews;
@property (strong, nonatomic) NSMutableArray *containerViews;
@property (strong, nonatomic) UIScrollView *scrollView;

- (void)configureView;
- (CGFloat)prevPointX;
- (CGFloat)nextPointX;
- (CGFloat)offsetWithPage:(NSUInteger)page;
- (UIView *)containerViewWithPage:(NSUInteger)page;
@end

@implementation ASCPageView

NSUInteger PageSize = 3;

- (id)initWithContentView:(UIView *)contentView
{
    CGRect frame = contentView.frame;
    if ((self = [super initWithFrame:frame])) {
        _containerViews = [[NSMutableArray alloc] initWithCapacity:PageSize];
        for (NSUInteger page = 0; page < PageSize; page++) {
            [_containerViews addObject:[self containerViewWithPage:page]];
        }

        _contentViews = [[NSMutableArray alloc] init];
        [_contentViews addObject:contentView];

        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)addContentView:(UIView *)contentView 
{
    if ([self.contentViews containsObject:contentView]) {
        return;
    }

    [self.contentViews addObject:contentView];
    if (self.contentViews.count <= PageSize) {
        [self configureView];
    }
}

- (void)setPage:(NSUInteger)page animated:(BOOL)animated
{
    if (page >= PageSize) {
        page = PageSize - 1;
    }
    [self.scrollView setContentOffset: CGPointMake([self offsetWithPage:page], 0)
                             animated: animated];
}


#pragma mark - Private

- (void)configureView
{
    for (UIView *subView in self.scrollView.subviews) {
        [subView removeFromSuperview];
    }
   
    NSUInteger page = 0;
    for (UIView *contentView in self.contentViews) {
        [self.containerViews[page] addSubview:contentView];
        [self.scrollView addSubview:self.containerViews[page]];
        page++;
    }
    if (page == 0) {
        return;
    }

    CGRect lastContainerFrame = [self.containerViews[page - 1] frame];
    self.scrollView.contentSize = CGSizeMake(lastContainerFrame.origin.x + lastContainerFrame.size.width, 0);
}

- (CGFloat)prevPointX
{
    NSInteger page = (self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if (page < 0) {
        page = 0;
    }
    return [self offsetWithPage:page];
}

- (CGFloat)nextPointX
{
    NSUInteger page = (self.scrollView.contentOffset.x / self.scrollView.frame.size.width) + 1;
    if (page >= PageSize) {
        page = PageSize - 1;
    }
    return [self offsetWithPage:page];
}

- (CGFloat)offsetWithPage:(NSUInteger)page
{
    return page * self.scrollView.frame.size.width;
}

- (UIView *)containerViewWithPage:(NSUInteger)page
{
    return [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x + (self.frame.size.width * page),
                                                    self.frame.origin.y,
                                                    self.frame.size.width,
                                                    self.frame.size.height)];
}


#pragma mark - UIScrollView

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat offsetX = 0;
    if (velocity.x <= -1) {
        offsetX = [self prevPointX];
    } else if (velocity.x >= 1) {
        offsetX = [self nextPointX];
    } else {
        NSUInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width;
        if (page >= PageSize) {
            page = PageSize - 1;
        }
        offsetX = [self offsetWithPage:page];
    }

    NSUInteger page = offsetX / self.scrollView.frame.size.width;
    if (page == 0) {
        [self.delegate pageViewDidFirstPage:self];
    } else if (page >= PageSize - 1) {
        [self.delegate pageViewDidLastPage:self];
    }

    targetContentOffset->x = offsetX;
    [self.scrollView setContentOffset:CGPointMake(targetContentOffset->x, 0) animated:NO];
    if (self.isInfinitePage) {
        targetContentOffset->x = [self offsetWithPage:PageSize / 2];
    }
}

@end
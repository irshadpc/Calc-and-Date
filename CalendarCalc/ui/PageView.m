//
//  PageView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/18.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "PageView.h"

typedef enum {
    MovePrev,
    MoveNext,
    MoveEnd,
} Move;

@interface PageView ()
@property(nonatomic) Move currentMove;
@property(nonatomic) NSInteger currentPage;
@property(strong, nonatomic) NSArray *contentViews;
@property(strong, nonatomic) NSArray *containerViews;
@property(strong, nonatomic) UIScrollView *scrollView;

- (void)configureView;
- (CGFloat)prevPointX;
- (CGFloat)nextPointX;
- (CGFloat)offsetWithPage:(NSInteger)page;
- (UIView *)containerViewWithPage:(NSInteger)page;
@end

@implementation PageView

static const NSUInteger PageSize = 3;

- (id)initWithContentView:(UIView *)contentView
                 prevPage:(UIView *)prevView
                 nextPage:(UIView *)nextView
{
    CGRect frame = contentView.frame;
    if ((self = [super initWithFrame:frame])) {
        _containerViews = @[[self containerViewWithPage:0],
                            [self containerViewWithPage:1],
                            [self containerViewWithPage:2]];
       
        _contentViews = @[prevView, contentView, nextView];

        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        [self addSubview:_scrollView];

        [self configureView];
    }
    return self;
}

- (void)setPage:(NSUInteger)page animated:(BOOL)animated
{
    if (page >= PageSize) {
        self.currentPage = PageSize - 1;
    } else {
        self.currentPage = page;
    }

    [self.scrollView setContentOffset:CGPointMake([self offsetWithPage:self.currentPage], 0)
                             animated:animated];
}

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    if (_pagingEnabled != pagingEnabled) {
        _pagingEnabled = pagingEnabled;
    }
    self.scrollView.scrollEnabled = _pagingEnabled;
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
    self.scrollView.contentSize = CGSizeMake(lastContainerFrame.origin.x + lastContainerFrame.size.width,
                                             self.scrollView.bounds.size.height);
}

- (CGFloat)prevPointX
{
    self.currentPage--;
    if (self.currentPage < 0) {
        self.currentPage = 0;
    }
    return [self offsetWithPage:self.currentPage];
}

- (CGFloat)nextPointX
{
    self.currentPage++;
    if (self.currentPage >= PageSize) {
        self.currentPage = PageSize - 1;
    }
    return [self offsetWithPage:self.currentPage];
}

- (CGFloat)offsetWithPage:(NSInteger)page
{
    if ([self.containerViews count] < page) {
        return 0;
    }
    return [self.containerViews[page] frame].origin.x;
}

- (UIView *)containerViewWithPage:(NSInteger)page
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
    if (velocity.x < 0) {
        offsetX = [self prevPointX];
    } else if (velocity.x > 0) {
        offsetX = [self nextPointX];
    } else {
        NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width;
        if (page >= PageSize) {
            page = PageSize - 1;
        }
        offsetX = [self offsetWithPage:page];
    }

    NSUInteger page = offsetX / self.scrollView.frame.size.width;

    [UIView animateWithDuration:0.1 animations:^{
        targetContentOffset->x = offsetX;
        [self.scrollView setContentOffset:CGPointMake(targetContentOffset->x, 0) animated:NO];
    }];
    
    if (page == 0) {
        self.currentMove = MovePrev;
    } else if (page >= PageSize - 1) {
        self.currentMove = MoveNext;
    } else {
        self.currentMove = MoveEnd;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.currentMove == MovePrev) {
            [self.delegate pageViewDidPrevPage:self];
        } else if (self.currentMove == MoveNext) {
            [self.delegate pageViewDidNextPage:self];
        }
    });
}
@end

//
//  UIView+Frame.m
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setFrameOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x,
                            origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (void)setFrameSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            size.width,
                            size.height);
}

- (void)setFrameOriginX:(CGFloat)x
{
    [self setFrameOrigin:CGPointMake(x, self.frame.origin.y)];
}

- (void)setFrameOriginY:(CGFloat)y
{
    [self setFrameOrigin:CGPointMake(self.frame.origin.x, y)];
}

- (void)setFrameSizeWidth:(CGFloat)width
{
    [self setFrameSize:CGSizeMake(width, self.frame.size.height)];
}

- (void)setFrameSizeHeight:(CGFloat)height
{
    [self setFrameSize:CGSizeMake(self.frame.size.width, height)];
}
@end

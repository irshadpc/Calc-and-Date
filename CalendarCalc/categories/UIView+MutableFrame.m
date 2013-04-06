//
//  UIView+MutableFrame.m
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIView+MutableFrame.h"

@implementation UIView (MutableFrame)
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
    self.frame = CGRectMake(x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (void)setFrameOriginY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x,
                            y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (void)setFrameSizeWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            width,
                            self.frame.size.height);
}

- (void)setFrameSizeHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            height);
}
@end

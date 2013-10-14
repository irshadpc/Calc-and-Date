//
//  UIView+Frame.h
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
- (void)setFrameOrigin:(CGPoint)origin;
- (void)setFrameSize:(CGSize)size;
- (void)setFrameOriginX:(CGFloat)x;
- (void)setFrameOriginY:(CGFloat)y;
- (void)setFrameSizeWidth:(CGFloat)width;
- (void)setFrameSizeHeight:(CGFloat)height;
@end

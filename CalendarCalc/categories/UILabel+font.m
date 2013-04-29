//
//  UILabel+font.m
//  WorkRecorder
//
//  Created by Ishida Junichi on 2012/12/14.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UILabel+font.h"

@implementation UILabel (font)
- (void)setMinimumScale:(CGFloat)scale
                 orSize:(CGFloat)size
{
    if ([self respondsToSelector:@selector(setMinimumScaleFactor:)]) {
        [self setMinimumScaleFactor:scale];
    } else {
        [self setMinimumFontSize:size];
    }
}
@end

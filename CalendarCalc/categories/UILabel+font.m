//
//  UILabel+font.m
//  WorkRecorder
//
//  Created by Ishida Junichi on 2012/12/14.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UILabel+font.h"

@implementation UILabel (font)

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (void)setMinimumScale:(CGFloat)scale
                 orSize:(CGFloat)size
{
    if ([self respondsToSelector:@selector(setMinimumScaleFactor:)]) {
        [self setMinimumScaleFactor:scale];
    } else {
        [self setMinimumFontSize:size];
    }
}
#pragma GCC diagnostic warning "-Wdeprecated-declarations"

@end

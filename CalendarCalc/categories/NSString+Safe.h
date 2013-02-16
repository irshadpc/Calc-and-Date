//
//  NSString+Safe.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/02/16.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe)
- (NSString *)safeSubstringToIndex:(NSUInteger)index;
@end

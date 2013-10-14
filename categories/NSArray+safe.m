//
//  NSArray+Safe.m
//  WorkRecorder
//
//  Created by Ishida Junichi on 2012/11/10.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)
- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (self.count <= index) {
        return nil;
    }
    return [self objectAtIndex:index];
}
@end

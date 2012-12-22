//
//  NSArray+safe.m
//  WorkRecorder
//
//  Created by Ishida Junichi on 2012/11/10.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSArray+safe.h"

@implementation NSArray (safe)

///////////////////////////////////////////////////////////////////////////////
- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end

//
//  NSArray+Safe.h
//  WorkRecorder
//
//  Created by Ishida Junichi on 2012/11/10.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)
- (id)safeObjectAtIndex:(NSUInteger)index;
@end

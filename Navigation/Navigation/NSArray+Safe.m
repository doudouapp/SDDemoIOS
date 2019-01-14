//
//  NSArray+Safe.m
//  Navigation
//
//  Created by dangshuai on 2019/1/8.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "NSArray+Safe.h"
#import "KMSwizzle.h"
@implementation NSArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KMSwizzleMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:), [self class], @selector(safe_objectAtIndexedSubscript:));
        KMSwizzleMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:), [self class], @selector(safe_objectAtIndex:));
        KMSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:), [self class], @selector(safe_m_objectAtIndexedSubscript:));
    });
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
       return [self safe_objectAtIndexedSubscript:idx];
    } else {
        return nil;
    }
}

- (id)safe_m_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self safe_m_objectAtIndexedSubscript:idx];
    } else {
        return nil;
    }
}

- (id)safe_objectAtIndex:(NSUInteger)idx {
    if (idx < self.count) {
        return [self safe_objectAtIndex:idx];
    } else {
        return nil;
    }
}

@end

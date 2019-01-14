//
//  NSDictionary+Safe.m
//  Navigation
//
//  Created by dangshuai on 2019/1/8.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (void)setObject:(id)obj forKeyedSubscript:( id<NSCopying>)key {
    if (!obj) {
        return;
    }
}

@end

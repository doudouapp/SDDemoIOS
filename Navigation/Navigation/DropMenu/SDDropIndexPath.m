//
//  SDDropIndexPath.m
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "SDDropIndexPath.h"
#import <UIKit/UIKit.h>
@implementation SDDropIndexPath
+ (instancetype)dropPathWithComponent:(NSInteger)component
                           withColumn:(NSInteger)column
                        withIndexPath:(NSIndexPath *)indexPath {
    SDDropIndexPath *idx = [[SDDropIndexPath alloc] init];
    idx.component = component;
    idx.column = column;
    idx.indexPath = indexPath;
    return idx;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"component == %zd,\ncolum == %zd,  \n section == %zd,\n row == %zd",_component,_column,self.indexPath.section, _indexPath.row];
}

@end

//
//  SDDropIndexPath.h
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  component       上边导航栏索引
 *  column          列，有些选项卡会出现多列
 *  indexPath       具体选中的tableview 或 collectionview 的索引
 */




@interface SDDropIndexPath : NSObject
@property (nonatomic, assign) NSInteger component;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, strong) NSIndexPath *indexPath;


+ (instancetype)dropPathWithComponent:(NSInteger)component withColumn:(NSInteger)column withIndexPath:(NSIndexPath *)indexPath;
@end



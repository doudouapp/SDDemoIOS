//
//  SDDropComponentModel.h
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDDropComponentModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *indicatorName;

@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, copy) NSString *heightlightImageName;

@end

@interface SDDropTableModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *children;
@end

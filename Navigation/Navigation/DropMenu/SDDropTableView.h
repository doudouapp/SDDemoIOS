//
//  SDDropTableView.h
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDDropIndexPath.h"
@protocol SDDropTableViewDelegate <NSObject>

- (void)dropTableView:(id)tableview dropPath:(SDDropIndexPath *)dropIndex;

@end

@interface SDDropTableView : UIView

@property (nonatomic, weak) id<SDDropTableViewDelegate> delegate;

@property (nonatomic, assign) NSInteger totalColumes;

@property (nonatomic, assign) NSInteger currentColumn;

@property (nonatomic, assign) NSInteger currentComponent;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

- (instancetype)initWithDataSource:(NSArray *)dataSource;

- (void)reloadTableView:(NSArray *)datasource;

@end



@interface SDDropTableViewCell : UITableViewCell

@end

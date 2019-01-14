//
//  SDDropMenuView.h
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDDropComponentModel.h"
#import "SDDropIndexPath.h"
@class SDDropMenuView;

@protocol SDDropMenuViewDataSource <NSObject>

- (NSInteger)menuView:(SDDropMenuView *)menuView numberOfColumnesInComponet:(NSInteger)section;

- (NSArray *)menuView:(SDDropMenuView *)menuView dataSourceForComponentIndex:(NSInteger)component;

- (NSArray *)menuView:(SDDropMenuView *)menuView dataSourceForColumnAtDropPath:(SDDropIndexPath *)dropPath;

@end

@protocol SDDropMenuViewDelegate <NSObject>

- (void)menuView:(SDDropMenuView *)menuView mainTableViewDidSelected:(SDDropIndexPath *)dropIndex;

- (BOOL)menuView:(SDDropMenuView *)menuView mainTableViewShouldActionSelf:(SDDropIndexPath *)dropIndex;

@end

@interface SDDropMenuView : UIView

@property (nonatomic, weak) id<SDDropMenuViewDataSource> dataSource;
@property (nonatomic, weak) id<SDDropMenuViewDelegate> delegate;

@property (nonatomic, assign) CGFloat componentHeight;
@property (nonatomic, assign) CGFloat maxContentHeight;
@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *heightlightTitleColor;

@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, copy) NSString *heightlightImageName;

// ReadOnly
@property (nonatomic, readonly) NSInteger numberOfComponents;

- (instancetype)initWithComponents:(NSArray *)components;

- (void)updateCurrentComponentTitle:(NSString *)title heightlight:(BOOL)light;

@end



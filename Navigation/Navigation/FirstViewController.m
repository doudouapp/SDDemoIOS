//
//  FirstViewController.m
//  Navigation
//
//  Created by dangshuai on 2019/1/7.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "FirstViewController.h"
#import "SDDropMenuView.h"
#import "UIImage+Color.h"
@interface FirstViewController ()<SDDropMenuViewDataSource,SDDropMenuViewDelegate>

@property (nonatomic, strong) NSArray *firstTablesData;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ffirst";
    UIImage *img = [UIImage wmg_imageWithColor:[UIColor colorWithWhite:1 alpha:0.85]];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    SDDropComponentModel *m1 = [[SDDropComponentModel alloc] init];
    m1.title = @"区域";
    SDDropComponentModel *m2 = [[SDDropComponentModel alloc] init];
    m2.title = @"价格";
    SDDropComponentModel *m3 = [[SDDropComponentModel alloc] init];
    m3.title = @"排序";

    SDDropMenuView *menuView = [[SDDropMenuView alloc] initWithComponents:@[m1,m2,m3]];
    menuView.frame = CGRectMake(0, 100, CGRectGetWidth([UIScreen mainScreen].bounds), 45);
    menuView.dataSource = self;
    menuView.delegate = self;
    [self.view addSubview:menuView];
    
}

- (NSInteger)menuView:(SDDropMenuView *)menuView numberOfColumnesInComponet:(NSInteger)component {
    if (component == 0) {
        return 2;
    }
    return 1;
}

- (NSArray *)menuView:(SDDropMenuView *)menuView dataSourceForComponentIndex:(NSInteger)component {
    return self.firstTablesData[component];
}

- (NSArray *)menuView:(SDDropMenuView *)menuView dataSourceForColumnAtDropPath:(SDDropIndexPath *)dropPath {
    if (dropPath.component == 0) {
        if (dropPath.column == 0) {
            if (dropPath.indexPath.row == 2) {
                return @[@"朝阳",@"通州",@"五环"];
            } else if (dropPath.indexPath.row == 1) {
                return @[@"陆家嘴",@"虹桥",@"石化",@"租借",@"谁啊"];
            }
        }
    }
    return nil;
}

- (BOOL)menuView:(SDDropMenuView *)menuView mainTableViewShouldActionSelf:(SDDropIndexPath *)dropIndex {
    if (dropIndex.component == 0) {
        return YES;
    }
    return NO;
}

- (void)menuView:(SDDropMenuView *)menuView mainTableViewDidSelected:(SDDropIndexPath *)dropIndex {
    NSLog(@"selected >>> \n %@",[dropIndex description]);
    NSString *title = self.firstTablesData[dropIndex.component][dropIndex.indexPath.row];
    BOOL light = YES;
    if (dropIndex.component == 2 && dropIndex.indexPath.row == 0) {
        light = NO;
        title = @"排序";
    }
    if (dropIndex.component == 0 && dropIndex.indexPath.row == 0) {
        light = NO;
        title = @"区域";
    }
    [menuView updateCurrentComponentTitle:title heightlight:light];
}


- (NSArray *)firstTablesData {
    if (!_firstTablesData) {
        return @[@[@"不限",@"上海",@"北京",@"浙江",@"江苏",@"广东",@"深圳"],
                 @[@"从高到低",@"从低到高"],
                 @[@"默认",@"评论最高",@"最先发布",@"出货最多"]];
    }
    return _firstTablesData;
}

- (IBAction)showPhotoe:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [self presentViewController:picker animated:YES completion:NULL];
    
}

@end

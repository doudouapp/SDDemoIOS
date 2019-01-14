//
//  SDDropTableView.m
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "SDDropTableView.h"
#import "SDDropComponentModel.h"

@interface SDDropTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SDDropTableView {
    NSArray *_dataSource;
}

- (instancetype)initWithDataSource:(NSArray *)dataSource {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        [self createTableView];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    _tableView.frame = self.bounds;
//}

- (void)didMoveToSuperview {
    _tableView.frame = self.bounds;
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 44*5) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    tableView.tableFooterView = [UIView new];
    tableView.separatorColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    _tableView =tableView;
    [self addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)reloadTableView:(NSArray *)datasource {
    _dataSource = datasource;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_delegate dropTableView:self dropPath:[SDDropIndexPath dropPathWithComponent:_currentComponent withColumn:_currentColumn withIndexPath:indexPath]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDDropTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDDropTableViewCell"];
    if (!cell) {
        cell = [[SDDropTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SDDropTableViewCell"];
    }
//    if (_currentIndexPath.section == indexPath.section && _currentIndexPath.row == indexPath.row) {
//        [cell setSelected:YES animated:YES];
//    } else {
//        [cell setSelected:NO animated:YES];
//    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath {
    _currentIndexPath = currentIndexPath;
    [_tableView selectRowAtIndexPath:_currentIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

@end




@implementation SDDropTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.textLabel.textColor =  [UIColor colorWithRed:255/255.f green:200/255.f blue:0 alpha:1];
    } else {
        self.textLabel.textColor =  [UIColor colorWithRed:34/255.f green:34/255.f blue:34/255.f alpha:1];
    }
}

@end

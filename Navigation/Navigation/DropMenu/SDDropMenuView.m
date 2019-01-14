//
//  SDDropMenuView.m
//  Navigation
//
//  Created by dangshuai on 2019/1/10.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "SDDropMenuView.h"
#import "SDDropTableView.h"
@interface SDDropMenuView ()<SDDropTableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *selectedIndexPathDic;
@property (nonatomic, strong) NSMutableDictionary *contentTableViews;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *coverView;
@end

@implementation SDDropMenuView {
    NSArray *_components;
    NSMutableArray *_componentButtons;
    UIButton *_currentButton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithComponents:(NSArray *)components {
    self = [super init];
    if (self) {
        _components = components;
        self.backgroundColor = [UIColor whiteColor];
        [self propertyDefault];
        [self reloadComponentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat bw = floor(width/_componentButtons.count);
    for (int i = 0; i < _componentButtons.count; i++) {
        UIButton *b = _componentButtons[i];
        b.frame = CGRectMake(bw * i, 0, bw, _componentHeight);
    }
}

- (void)coverViewTap:(UITapGestureRecognizer *)tap {
    _currentButton.selected = NO;
    [self contentViewHidden];
}

- (void)contentViewHidden {
    self.frame = CGRectMake(0, 100, CGRectGetWidth(self.frame), _componentHeight);
    CGRect frame = _contentView.frame;
    frame.origin.y = -frame.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.alpha = 0;
        _coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    }];
}

- (void)componentButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSInteger component = sender.tag - 1000;
    if (_currentButton != sender) {
        _currentButton.selected = NO;
        _currentButton = sender;
    }
    
    if (sender.selected) {
        if (_delegate &&
            [_delegate respondsToSelector:@selector(menuView:mainTableViewShouldActionSelf:)]) {
            SDDropIndexPath *pth = [SDDropIndexPath dropPathWithComponent:component withColumn:0 withIndexPath:nil];
            if ([_delegate menuView:self mainTableViewShouldActionSelf:pth]) {
                [self contentViewHidden];
                return;
            }
        }
        NSInteger col = 1;
        self.coverView.alpha = 1;
        self.contentView.alpha = 1;
        if (_dataSource && [_dataSource respondsToSelector:@selector(menuView:numberOfColumnesInComponet:)]) {
            col =  [_dataSource menuView:self numberOfColumnesInComponet:component];
        }
        [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if (_dataSource && [_dataSource respondsToSelector:@selector(menuView:dataSourceForComponentIndex:)]) {
            NSArray *array = [_dataSource menuView:self dataSourceForComponentIndex:component];
            SDDropTableView *table = [[SDDropTableView alloc] initWithDataSource:array];
            table.delegate = self;
            table.totalColumes = col;
            table.currentColumn = 0;
            table.currentComponent = component;
            SDDropIndexPath *path = self.selectedIndexPathDic[[self componentString:component]];
            if (path) {
                table.currentIndexPath = path.indexPath;
            }
            self.contentView.frame = CGRectMake(0, _componentHeight, CGRectGetWidth([UIScreen mainScreen].bounds), MIN(_rowHeight * array.count, _maxContentHeight));
            table.frame = _contentView.bounds;
            [self.contentView addSubview:table];
        }

        CGRect f = self.frame;
        f.size.height = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetMinY(f);
        self.frame = f;
    } else {
        [self contentViewHidden];
    }
}

- (void)dropTableView:(SDDropTableView *)tableview dropPath:(SDDropIndexPath *)dropIndex {
//    if (tableview.totalColumes - 1 > dropIndex.column) {
//        NSArray *array = [_dataSource menuView:self dataSourceForColumnAtDropPath:dropIndex];
//
//        SDDropIndexPath *path = [SDDropIndexPath dropPathWithComponent:dropIndex.component withColumn:dropIndex.column + 1 withIndexPath:dropIndex.indexPath];
//        SDDropTableView *table = self.contentTableViews[[self contentTableViweKey:path]];
//        if (table) {
//            if (!table.superview) {
//                [self.contentView addSubview:table];
//            }
//            [table reloadTableView:array];
//        } else {
//            SDDropTableView *table = [[SDDropTableView alloc] initWithDataSource:array];
//            table.delegate = self;
//            table.totalColumes = tableview.totalColumes;
//            table.currentColumn = tableview.currentColumn + 1;
//            table.currentComponent = tableview.currentComponent;
//            table.frame = CGRectMake(100, 0, 375, _contentView.bounds.size.height);
//            [self.contentView addSubview:table];
//            self.contentTableViews[[self contentTableViweKey:path]] = table;
//        }
//
//        if (array) {
//            table.hidden = NO;
//        } else {
//            table.hidden = YES;
//        }
//    } else
    {
        [self recordSelectedIndex:dropIndex];
        [_delegate menuView:self mainTableViewDidSelected:dropIndex];
    }
}

- (void)updateCurrentComponentTitle:(NSString *)title heightlight:(BOOL)light {
    [_currentButton setTitle:title forState:0];
    [_currentButton setTitleColor:(light ? _heightlightTitleColor : _normalTitleColor) forState:0];
}

- (void)reloadComponentView {

    _componentButtons = [NSMutableArray arrayWithCapacity:_components.count];
    for (int i = 0; i < _components.count; i++) {
        SDDropComponentModel *m = _components[i];
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.titleLabel.font = [UIFont systemFontOfSize:15];
        b.tag = 1000 + i;
        [b setTitle:m.title forState:0];
        [b setTitleColor:_normalTitleColor forState:0];
        [b setTitleColor:_heightlightTitleColor forState:UIControlStateSelected];
        [b addTarget:self action:@selector(componentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:b];
        [_componentButtons addObject:b];
    }
    
    [self.layer addSublayer:[self  createLayer:CGRectMake(0, _componentHeight - 0.5, 500, 0.5)]];
}

- (void)propertyDefault {
    _componentHeight = 45.f;
    _rowHeight = 44.f;
    _maxContentHeight = _rowHeight * 5;
    
    _normalTitleColor = [UIColor colorWithRed:34/255.f green:34/255.f blue:34/255.f alpha:1];
    _heightlightTitleColor = [UIColor colorWithRed:255/255.f green:200/255.f blue:0 alpha:1];
}

- (NSMutableDictionary *)selectedIndexPathDic {
    if (!_selectedIndexPathDic) {
        _selectedIndexPathDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _selectedIndexPathDic;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(0, _componentHeight + 1, CGRectGetWidth([UIScreen mainScreen].bounds), 1);
        _contentView.alpha = 0;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIView *)coverView {
    if (!_coverView) {
        UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, _componentHeight, [UIScreen mainScreen].bounds.size.width, 900)];
        cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:cover];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTap:)];
        [cover addGestureRecognizer:tap];
        _coverView = cover;
    }
    return _coverView;
}

- (NSMutableDictionary *)contentTableViews {
    if (!_contentTableViews) {
        _contentTableViews = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _contentTableViews;
}

- (NSString *)contentTableViweKey:(SDDropIndexPath *)path {
    return [NSString stringWithFormat:@"component%zdcolumn%zd",path.component,path.column];
}


- (CALayer *)createLayer:(CGRect)frame {
    CALayer *l = [CALayer layer];
    l.frame = frame;
    l.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1].CGColor;
    return l;
}

- (void)recordSelectedIndex:(SDDropIndexPath *)dropPath {
    NSInteger com = dropPath.component;
    [self.selectedIndexPathDic setValue:dropPath forKey:[self componentString:com]];
}

- (NSString *)componentString:(NSInteger)com {
    return [NSString stringWithFormat:@"component%zd",com];
}

@end

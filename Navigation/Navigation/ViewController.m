//
//  ViewController.m
//  Navigation
//
//  Created by dangshuai on 2019/1/7.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "KMNavigationBarTransition.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect labelFrame = _colorLabel.frame;
//    CALayer *layer = [CALayer layer];
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.frame = CGRectMake(0, 0, CGRectGetMidX(labelFrame), CGRectGetHeight(labelFrame));
//    [_colorLabel.layer addSublayer:layer];
//    _colorLabel.layer.mask = layer;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor blackColor].CGColor];
    gradient.frame = labelFrame;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.locations = @[@0,@0.32,@0.32,@1];
    gradient.mask = _colorLabel.layer;
    _colorLabel.frame = _colorLabel.bounds;
    [self.view.layer addSublayer: gradient];
}

- (IBAction)nextViewcontroller:(UIButton *)sender {
    
    FirstViewController *fir = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    [self.navigationController pushViewController:fir animated:YES];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear: animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}


@end

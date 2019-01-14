//
//  UIImage+Color.h
//  Navigation
//
//  Created by dangshuai on 2019/1/8.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIImage (Color)
+ (UIImage *)wmg_imageWithColor:(UIColor *)color size:(CGSize)size borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor ;

+ (UIImage *)wmg_imageWithColor:(UIColor *)color;

@end



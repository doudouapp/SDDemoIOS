//
//  UIImage+Color.m
//  Navigation
//
//  Created by dangshuai on 2019/1/8.
//  Copyright © 2019 dangshuai. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)wmg_imageWithColor:(UIColor *)color {
    return [self wmg_imageWithColor:color size:CGSizeMake(1, 1) borderWidth:0 borderColor:nil];
}

+ (UIImage *)wmg_imageWithColor:(UIColor *)color size:(CGSize)size borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (!context) {
        return nil;
    }
    
//    if (!WMGCornerRadiusIsValid(radius))
    {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
        if(width > 0)
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
            CGContextAddPath(context, path.CGPath);
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, width);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
    }
//    else
//    {
//        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//        CGContextFillRect(context, rect);
//
//        UIBezierPath *path = [UIBezierPath wmg_bezierPathWithRect:rect cornerRadius:radius lineWidth:width];
//        [path setUsesEvenOddFillRule:YES];
//        [path addClip];
//        CGContextAddPath(context, path.CGPath);
//
//        CGContextSetFillColorWithColor(context, [color CGColor]);
//        CGContextFillRect(context, rect);
//
//        CGContextAddPath(context, path.CGPath);
//
//        if (width > 0.0)
//        {
//            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
//            CGContextSetLineWidth(context, width);
//            CGContextDrawPath(context, kCGPathFillStroke);
//        }
//        else
//        {
//            CGContextDrawPath(context, kCGPathFill);
//        }
//    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end

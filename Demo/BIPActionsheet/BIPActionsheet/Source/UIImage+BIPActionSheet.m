//
//  UIImage+BIPActionSheet.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import "UIImage+BIPActionSheet.h"

@implementation UIImage (BIPActionSheet)

+ (UIImage *)bip_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    return [[self class] bip_imageWithColor:color withFrame:rect];
}

+ (UIImage *)bip_imageWithColor:(UIColor *)color withFrame:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

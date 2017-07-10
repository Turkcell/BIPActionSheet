//
//  UIWindow+BIPActionSheet.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import "UIWindow+BIPActionSheet.h"

@implementation UIWindow (BIPActionSheet)

+ (UIWindow *)bip_windowWithLevel:(UIWindowLevel)windowLevel
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows)
    {
        if (window.windowLevel == windowLevel)
        {
            return window;
        }
    }
    
    return nil;
}

+ (CGFloat)bip_maxWindowLevelCurrently
{
    CGFloat maxWindowLevel = 0;
    NSArray * windows = [[UIApplication sharedApplication] windows];
    
    for (UIWindow * window in windows)
    {
        CGFloat currentWindowLevel = window.windowLevel;
        
        if (currentWindowLevel > maxWindowLevel)
        {
            maxWindowLevel = currentWindowLevel;
        }
    }
    
    return maxWindowLevel;
}

@end

//
//  UIWindow+BIPActionSheet.h
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (BIPActionSheet)

+ (UIWindow *)bip_windowWithLevel:(UIWindowLevel)windowLevel;
+ (CGFloat)bip_maxWindowLevelCurrently;

@end

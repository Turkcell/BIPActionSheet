//
//  UIApplication+BIPActionSheet.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import "UIApplication+BIPActionSheet.h"

@implementation UIApplication (BIPActionSheet)

- (BOOL)bip_isLandscape
{
    return UIInterfaceOrientationIsLandscape([self statusBarOrientation]);
}

@end

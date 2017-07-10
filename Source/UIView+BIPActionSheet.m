//
//  UIView+BIPActionSheet.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import "UIView+BIPActionSheet.h"

@implementation UIView (BIPActionSheet)

- (CGFloat)bip_yOrigin
{
    return CGRectGetMinY(self.frame);
}

- (void)setBip_yOrigin:(CGFloat)yOrigin
{
    CGRect frame = self.frame;
    frame.origin.y = yOrigin;
    self.frame = frame;
}

@end

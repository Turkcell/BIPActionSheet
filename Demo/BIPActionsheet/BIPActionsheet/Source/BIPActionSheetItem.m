//
//  BIPActionSheetItem.m
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "BIPActionSheetItem.h"
#import "BIPActionSheetConstants.h"

@implementation BIPActionSheetItem

#pragma mark - Initialize

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                actionHandler:(BIPActionSheetActionHandler)actionHandler
{
    if (self = [super init])
    {
        self.title          = [title copy];
        self.image          = image;
        self.actionHandler  = actionHandler;
    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(UIImage *)image
                actionHandler:(BIPActionSheetActionHandler)actionHandler
{
    return [[self alloc] initWithTitle:title
                                 image:image
                             textColor:nil
                         actionHandler:actionHandler];
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                    textColor:(UIColor *)textColor
                actionHandler:(BIPActionSheetActionHandler)actionHandler
{
    if (self = [super init])
    {
        self.title          = [title copy];
        self.image          = image;
        self.textColor      = textColor;
        self.actionHandler  = actionHandler;
    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(UIImage *)image
                    textColor:(UIColor *)textColor
                actionHandler:(BIPActionSheetActionHandler)actionHandler
{
    return [[self alloc] initWithTitle:title
                                 image:image
                             textColor:textColor
                         actionHandler:actionHandler];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    BIPActionSheetItem *copyItem = [[self class] allocWithZone:zone];
    
    if (copyItem)
    {
        copyItem.title          = self.title;
        copyItem.image          = self.image;
        copyItem.textColor      = self.textColor;
        copyItem.actionHandler  = self.actionHandler;
    }
    
    return copyItem;
}

@end

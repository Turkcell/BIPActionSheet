//
//  BIPActionSheetItem.h
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIPActionSheet;

typedef void(^BIPActionSheetActionHandler)(BIPActionSheet *actionSheet);

@interface BIPActionSheetItem : NSObject <NSCopying>

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(UIImage *)image
                actionHandler:(BIPActionSheetActionHandler)actionHandler;

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(UIImage *)image
                    textColor:(UIColor *)textColor
                actionHandler:(BIPActionSheetActionHandler)actionHandler;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                actionHandler:(BIPActionSheetActionHandler)actionHandler;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                    textColor:(UIColor *)textColor
                actionHandler:(BIPActionSheetActionHandler)actionHandler;


@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, strong) UIColor  *textColor;

@property (nonatomic, copy) void (^actionHandler)(BIPActionSheet *actionSheet);


@end

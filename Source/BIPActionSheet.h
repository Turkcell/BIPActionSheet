//
//  BIPActionSheet.h
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIPActionSheetItem;

@interface BIPActionSheet : UIViewController <NSCopying>

- (instancetype)initWithItems:(NSArray <BIPActionSheetItem *> *)items
            cancelButtonTitle:(NSString *)cancelButtonTitle
                cancelHandler:(void(^)(void))cancelHandler;

- (instancetype)initWithTitle:(NSString *)title
                        items:(NSArray <BIPActionSheetItem *> *)items
            cancelButtonTitle:(NSString *)cancelButtonTitle
                cancelHandler:(void(^)(void))cancelHandler;

+ (instancetype)showActionSheetWithItems:(NSArray<BIPActionSheetItem *> *)items
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                           cancelHandler:(void(^)(void))cancelHandler;

+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                   items:(NSArray<BIPActionSheetItem *> *)items
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                           cancelHandler:(void(^)(void))cancelHandler;

- (void)show;
- (void)hide;

- (void)showInternal;
- (void)dismiss;

@property (nonatomic, assign, readonly, getter=isVisible) BOOL visible;
@property (nonatomic, strong) UIButton *cancelButton;

+ (BOOL)isAnyActionsheetVisible;
+ (void)dismissLastActiveActionsheet;
+ (void)dismissAllActionsheets;

@end

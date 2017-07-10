//
//  BIPActionSheetItemView.h
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BIPActionSheetImageAllignment) {
    Left,
    Right
};

@class BIPActionSheetItem, BIPActionSheet;

@interface BIPActionSheetItemView : UIView <NSCopying>

/** Initialize with Item to show up */

- (instancetype)initWithItem:(BIPActionSheetItem *)item
              isHeadlineItem:(BOOL)isHeadlineItem
                  ownerSheet:(BIPActionSheet *)ownerSheet;

/** Customize fonti color attributes using Apperance */

@property (nonatomic, strong) UIFont  *titleFont  UI_APPEARANCE_SELECTOR; // defaults [UIFont systemFontOfSize:13.f]

@property (nonatomic, strong) UIColor *titleTextColor UI_APPEARANCE_SELECTOR; // defaults [UIColor darkGrayColor]

@property (nonatomic, strong) UIFont  *itemFont UI_APPEARANCE_SELECTOR; // defaults [UIFont systemFontOfSize:18]

@property (nonatomic, strong) UIColor *itemTextColor UI_APPEARANCE_SELECTOR; // defaults [UIColor darkGrayColor]

@property (nonatomic, strong) UIFont  *cancelButtonFont   UI_APPEARANCE_SELECTOR; // defaults [UIFont boldSystemFontOfSize:18]

@property (nonatomic, strong) UIColor *cancelButtonColor  UI_APPEARANCE_SELECTOR; // defaults [UIColor redColor]

@property (nonatomic, assign) BIPActionSheetImageAllignment imageAlignment UI_APPEARANCE_SELECTOR; // defaults Left

@property (nonatomic, assign) CGFloat imageWidth UI_APPEARANCE_SELECTOR; // defaults 23.5
@property (nonatomic, assign) CGFloat imageHeight UI_APPEARANCE_SELECTOR; // defaults 23.5

@end

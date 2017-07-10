//
//  BIPActionSheetStack.h
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BIPActionSheet;

@interface BIPActionSheetStack : NSObject

+ (instancetype)sharedInstance;

- (void)push:(BIPActionSheet *)actionSheet;
- (void)pop:(BIPActionSheet *)actionSheet;
- (void)pop:(BIPActionSheet *)actionSheet showNext:(BOOL)showNext;

- (BOOL)containsActionSheetInStack:(BIPActionSheet *)actionsheet;

@property (nonatomic, strong) NSMutableArray <BIPActionSheet *> *actionSheets;


@end

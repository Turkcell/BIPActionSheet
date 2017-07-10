//
//  BIPActionSheetStack.m
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "BIPActionSheetStack.h"
#import "BIPActionSheet.h"
#import "BIPActionSheetConstants.h"

@implementation BIPActionSheetStack

#pragma mark - Initialize

+ (instancetype)sharedInstance
{
    static BIPActionSheetStack *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BIPActionSheetStack alloc] init];
        _sharedInstance.actionSheets = [NSMutableArray array];
    });
    
    return _sharedInstance;
}

#pragma mark - Push / Pop Stacks

- (void)push:(BIPActionSheet *)actionSheet
{
    @synchronized (self) {
        [self.actionSheets addObject:actionSheet];
        
        if (self.actionSheets.count == 1)
        {
            [actionSheet showInternal];
        }
    }
}

- (void)pop:(BIPActionSheet *)actionSheet showNext:(BOOL)showNext
{
    @synchronized (self) {
        
        [actionSheet hide];
        [self.actionSheets removeObject:actionSheet];
        
        if (showNext)
        {
            BIPActionSheet *last = [self.actionSheets lastObject];
            
            if (last)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBIPActionSheetHideAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [last showInternal];
                });
            }
        }
    }
}

- (void)pop:(BIPActionSheet *)actionSheet
{
    [self pop:actionSheet showNext:YES];
}

#pragma mark - Check Contains

- (BOOL)containsActionSheetInStack:(BIPActionSheet *)actionsheet
{
    return [self.actionSheets containsObject:actionsheet];
}

@end

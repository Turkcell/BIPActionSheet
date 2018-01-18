//
//  BIPActionSheet.m
//  BIP
//
//  Created by AHMET KAZIM GUNAY on 02/06/2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "BIPActionSheet.h"
#import "BIPActionSheetItem.h"
#import "BIPActionSheetStack.h"
#import "BIPActionSheetItemView.h"
#import "BIPActionSheetConstants.h"
#import "UIWindow+BIPActionSheet.h"
#import "UIImage+BIPActionSheet.h"
#import "UIView+BIPActionSheet.h"
#import "UIApplication+BIPActionSheet.h"

@interface BIPActionSheet()

@property (nonatomic, strong) NSMutableArray <BIPActionSheetItem *> *items;
@property (nonatomic, strong) NSMutableArray <BIPActionSheetItemView *> *itemViews;

@property (nonatomic, strong) UIWindow *actionSheetWindow;
@property (nonatomic, strong) UIWindow *applicationWindow;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, copy) NSString *cancelButtonTitle;

@property (nonatomic, assign, readwrite, getter=isVisible) BOOL visible;

@property (nonatomic, assign) CGFloat containerYOrigin;
@property (nonatomic, assign) CGFloat cancelYOrigin;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) CGFloat contentViewWidth;
@property (nonatomic, assign) CGFloat paddingOffset;

@property (nonatomic, copy) void (^inlineCancelHandler)(void);

@property (nonatomic, strong) BIPActionSheetItemView *titleItemView;

@property (nonatomic, assign) BOOL isStatusBarHiddenForRootViewController;

@end

@implementation BIPActionSheet

static inline bool bip_isPad() {
    
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

#pragma mark - Initialize

- (instancetype)initWithTitle:(NSString *)title
                        items:(NSArray<BIPActionSheetItem *> *)items
            cancelButtonTitle:(NSString *)cancelButtonTitle
                cancelHandler:(void (^)(void))cancelHandler
{
    if (self = [[BIPActionSheet alloc] initWithItems:items cancelButtonTitle:cancelButtonTitle cancelHandler:cancelHandler])
    {
        if (title.length)
        {
            BIPActionSheetItem *titleItem = [BIPActionSheetItem itemWithTitle:title image:nil actionHandler:nil];
            self.titleItemView = [[BIPActionSheetItemView alloc] initWithItem:titleItem isHeadlineItem:YES ownerSheet:self];
            [self.containerView addSubview:self.titleItemView];
        }
    }
    return self;
}

- (instancetype)initWithItems:(NSArray<BIPActionSheetItem *> *)items
            cancelButtonTitle:(NSString *)cancelButtonTitle
                cancelHandler:(void (^)(void))cancelHandler
{
    if (self = [super init])
    {
        self.inlineCancelHandler = cancelHandler;
        self.items               = [NSMutableArray arrayWithArray:items];
        self.itemViews           = [NSMutableArray arrayWithCapacity:items.count];
        self.cancelButtonTitle   = cancelButtonTitle;
        self.applicationWindow   = [UIWindow bip_windowWithLevel:UIWindowLevelNormal];
        
        for (BIPActionSheetItem *item in items)
        {
            BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:item isHeadlineItem:NO ownerSheet:self];
            [self.scrollView addSubview:itemView];
            [self.itemViews addObject:itemView];
        }
        
        [self.containerView addSubview:self.scrollView];
        [self.view addSubview:self.backgroundView];
        [self.view addSubview:self.containerView];
        
        if (!bip_isPad())
        {
            [self.view addSubview:self.cancelButton];
        }
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self.backgroundView addGestureRecognizer:tgr];
    }
    return self;
}

#pragma mark - Tap Gesture

- (void)tapped:(UITapGestureRecognizer *)recognizer
{
    [self actionSheetCancelButtonTapped:self.cancelButton];
}

#pragma mark - Show ActionSheet

+ (instancetype)showActionSheetWithItems:(NSArray<BIPActionSheetItem *> *)items
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                           cancelHandler:(void(^)(void))cancelHandler;
{
    BIPActionSheet *actionSheet = [[BIPActionSheet alloc] initWithItems:items
                                                      cancelButtonTitle:cancelButtonTitle
                                                          cancelHandler:cancelHandler];
    [actionSheet show];
    
    return actionSheet;
}

+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                   items:(NSArray<BIPActionSheetItem *> *)items
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                           cancelHandler:(void (^)(void))cancelHandler
{
    BIPActionSheet *actionSheet = [[BIPActionSheet alloc] initWithTitle:title
                                                                  items:items
                                                      cancelButtonTitle:cancelButtonTitle
                                                          cancelHandler:cancelHandler];
    [actionSheet show];
    
    return actionSheet;
}

- (void)show
{
    [[BIPActionSheetStack sharedInstance] push:self];
}

- (void)showInternal
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.isStatusBarHiddenForRootViewController = self.applicationWindow.rootViewController.prefersStatusBarHidden;
       
        [self.actionSheetWindow setRootViewController:self];
        [self.actionSheetWindow makeKeyAndVisible];
        self.visible = YES;
        
        [UIView animateWithDuration:kBIPActionSheetShowAnimationDuration
                         animations:^{
                             self.backgroundView.alpha  = kBIPActionSheetBackgroundAlpha;
                         }
         ];
        
        if (!bip_isPad())
        {
            [UIView animateWithDuration:kBIPActionSheetShowAnimationDuration
                                  delay:kBIPActionSheetShowAnimationDuration / 2
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:0.6
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.cancelButton.bip_yOrigin  = self.cancelYOrigin;
                             }
                             completion:^(BOOL finished) {
                                 //Completion Block
                             }
             ];
            
            [UIView animateWithDuration:kBIPActionSheetShowAnimationDuration
                                  delay:0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:0.6
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.containerView.bip_yOrigin = self.containerYOrigin;
                             }
                             completion:^(BOOL finished) {
                                 //Completion Block
                             }
             ];
        }
        else
        {
            [self showAlertAnimation];
        }
        
    });
}

#pragma mark - Class Methods

+ (BOOL)isAnyActionsheetVisible
{
    return [BIPActionSheetStack sharedInstance].actionSheets.count > 0;
}

+ (void)dismissVisibleActionsheet
{
    if ([self isAnyActionsheetVisible])
    {
        BIPActionSheet *as = [BIPActionSheetStack sharedInstance].actionSheets.lastObject;
        [as dismiss];
    }
}

+ (void)dismissAllActionsheets
{
    while ([BIPActionSheetStack sharedInstance].actionSheets.count > 0)
    {
        BIPActionSheet *as = [BIPActionSheetStack sharedInstance].actionSheets.lastObject;
        [[BIPActionSheetStack sharedInstance] pop:as showNext:NO];
    }
}

#pragma mark - Hide ActionSheet

- (void)dismiss
{
    [[BIPActionSheetStack sharedInstance] pop:self];
}

- (void)hide
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [UIView animateWithDuration:kBIPActionSheetHideAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundView.alpha  = 0;
                             self.containerView.bip_yOrigin = self.view.frame.size.height;
                             self.cancelButton.bip_yOrigin  = self.view.frame.size.height;
                         }
                         completion:^(BOOL finished) {
                             self.visible = NO;
                             [self.actionSheetWindow removeFromSuperview];
                             self.actionSheetWindow.rootViewController = nil;
                             self.actionSheetWindow = nil;
                             [self.applicationWindow makeKeyAndVisible];
                         }
         ];
    });
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.backgroundView.frame = self.actionSheetWindow.bounds;
    
    if (!bip_isPad())
    {
        [self validateLayoutForiPhone];
    }
    else
    {
        [self validateLayoutForiPad];
    }
}

- (void)validateLayoutForiPhone
{
    // cancelButton Frame
    CGRect cancelButtonRect        = CGRectZero;
    cancelButtonRect.origin.x      = self.paddingOffset;
    cancelButtonRect.size.width    = self.contentViewWidth;
    cancelButtonRect.size.height   = kBIPActionSheetRowHeight;
    
    // containerView Frame
    CGRect containerViewRect        = CGRectZero;
    containerViewRect.origin.x      = self.paddingOffset;
    containerViewRect.size.width    = self.contentViewWidth;
    containerViewRect.size.height   = self.contentViewHeight;
    
    if (self.isVisible)
    {
        cancelButtonRect.origin.y  = self.cancelYOrigin;
        containerViewRect.origin.y = self.containerYOrigin;
    }
    
    self.cancelButton.frame  = cancelButtonRect;
    self.containerView.frame = containerViewRect;
    
    self.scrollView.frame       = [self isTitleViewExist] ? CGRectMake(0, kBIPActionSheetRowHeight, self.contentViewWidth, self.contentViewHeight - kBIPActionSheetRowHeight) : self.containerView.bounds;
    
    CGFloat contentHeight       = self.items.count * kBIPActionSheetRowHeight;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, contentHeight);
    
    for (int i = 0; i<self.itemViews.count; i++)
    {
        BIPActionSheetItemView *itemView = self.itemViews[i];
        
        // itemView Frame
        CGRect itemViewRect        = CGRectZero;
        itemViewRect.origin.x      = 0;
        itemViewRect.origin.y      = i * kBIPActionSheetRowHeight;
        itemViewRect.size.width    = containerViewRect.size.width;
        itemViewRect.size.height   = kBIPActionSheetRowHeight;
        itemView.frame             = itemViewRect;
    }
    
    self.titleItemView.frame = CGRectMake(0, 0, self.contentViewWidth, kBIPActionSheetRowHeight);
}

- (void)validateLayoutForiPad
{
    // containerView Frame
    CGRect containerViewRect        = CGRectZero;
    containerViewRect.size.width    = self.contentViewWidth;
    containerViewRect.size.height   = self.contentViewHeight;
    self.containerView.frame        = containerViewRect;

    if (self.isVisible)
    {
        self.containerView.center = self.view.center;
    }
    
    self.scrollView.frame       = [self isTitleViewExist] ? CGRectMake(0, kBIPActionSheetRowHeight, self.contentViewWidth, self.contentViewHeight - kBIPActionSheetRowHeight) : self.containerView.bounds;
    CGFloat contentHeight       = self.items.count * kBIPActionSheetRowHeight;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, contentHeight);
    
    for (int i = 0; i<self.itemViews.count; i++)
    {
        BIPActionSheetItemView *itemView = self.itemViews[i];
        
        // itemView Frame
        CGRect itemViewRect        = CGRectZero;
        itemViewRect.origin.x      = 0;
        itemViewRect.origin.y      = i * kBIPActionSheetRowHeight;
        itemViewRect.size.width    = containerViewRect.size.width;
        itemViewRect.size.height   = kBIPActionSheetRowHeight;
        itemView.frame             = itemViewRect;
    }
    
    self.titleItemView.frame = CGRectMake(0, 0, self.contentViewWidth, kBIPActionSheetRowHeight);
}

- (void)showAlertAnimation
{
    self.containerView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 0, 0);
    
    [UIView animateWithDuration:kBIPActionSheetShowAnimationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect containerViewRect        = CGRectZero;
                         containerViewRect.size.width    = self.contentViewWidth;
                         containerViewRect.size.height   = self.contentViewHeight;
                         self.containerView.frame = containerViewRect;
                         
                         self.containerView.center = self.view.center;
                     }
                     completion:^(BOOL finished) {
                         //Completion Block
                     }
     ];
}

#pragma mark - Orientation

- (BOOL)prefersStatusBarHidden
{
    return [UIApplication sharedApplication].bip_isLandscape ? YES : self.isStatusBarHiddenForRootViewController;
}

- (BOOL)shouldAutorotate
{
    return self.applicationWindow.rootViewController.shouldAutorotate;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return self.applicationWindow.rootViewController.supportedInterfaceOrientations;
}

#pragma mark - Lazy Initializers

- (UIWindow *)applicationWindow
{
    return [UIWindow bip_windowWithLevel:UIWindowLevelNormal];
}

- (UIWindow *)actionSheetWindow
{
    if(!_actionSheetWindow)
    {
        _actionSheetWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _actionSheetWindow.backgroundColor = [UIColor clearColor];
        
        //	this window should be above all windows
        UIWindowLevel suitableWindowLevel = [UIWindow bip_maxWindowLevelCurrently] + 1;
        _actionSheetWindow.windowLevel = suitableWindowLevel;
    }
    
    return _actionSheetWindow;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    }
    
    return _scrollView;
}

- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 0, 0)];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 10.f;
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _containerView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, self.view.frame.size.height, 0, 0);
        [_cancelButton addTarget:self action:@selector(actionSheetCancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundImage:[UIImage bip_imageWithColor:[UIColor colorWithWhite:0 alpha:0.1]] forState:UIControlStateHighlighted];
        [_cancelButton setBackgroundImage:[UIImage bip_imageWithColor:[UIColor colorWithWhite:0 alpha:0.1]] forState:UIControlStateSelected];
        [_cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 10.f;
    }
    
    return _cancelButton;
}

- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.f;
    }
    
    return _backgroundView;
}

- (CGFloat)containerYOrigin
{
    return self.cancelYOrigin - self.paddingOffset - self.contentViewHeight;
}

- (CGFloat)contentViewHeight
{
    CGFloat contentHeight = 0.f;
    
    NSInteger numberOfTotalItems = self.items.count;
    
    if ([self isTitleViewExist]) // there is title on actionsheet
    {
        numberOfTotalItems += 1;
    }
    
    if (bip_isPad())
    {
        contentHeight = MIN(numberOfTotalItems * kBIPActionSheetRowHeight, self.view.frame.size.height - (2 * self.paddingOffset));
    }
    else
    {
        contentHeight = MIN(numberOfTotalItems * kBIPActionSheetRowHeight, self.view.frame.size.height - (3 * self.paddingOffset) - kBIPActionSheetRowHeight);
    }
    
    return contentHeight;
}

- (CGFloat)contentViewWidth
{
    return self.view.frame.size.width - 2 * self.paddingOffset;
}

- (CGFloat)cancelYOrigin
{
    return self.view.frame.size.height - self.paddingOffset - kBIPActionSheetRowHeight - UIWindow.safeAreaInset.bottom;
}

- (CGFloat)paddingOffset
{
    return bip_isPad() ? kBIPActionSheetPaddingOffsetiPAD : kBIPActionSheetPaddingOffset;
}

#pragma mark - Private Helpers

- (BOOL)isTitleViewExist
{
    return self.titleItemView != nil;
}

#pragma mark - Cancel Button Action

- (void)actionSheetCancelButtonTapped:(UIButton *)sender
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBIPActionSheetHideAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.inlineCancelHandler)
        {
            self.inlineCancelHandler();
        }
    });

    sender.selected = YES;
    [self dismiss];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    BIPActionSheet *copySheet = [[self class] allocWithZone:zone];
    
    if (copySheet)
    {
        copySheet.visible               = self.visible;
        copySheet.actionSheetWindow     = self.actionSheetWindow;
        copySheet.applicationWindow     = self.applicationWindow;
        copySheet.scrollView            = self.scrollView;
        copySheet.containerView         = self.containerView;
        copySheet.backgroundView        = self.backgroundView;
        copySheet.cancelButton          = self.cancelButton;
        copySheet.containerYOrigin      = self.containerYOrigin;
        copySheet.cancelYOrigin         = self.cancelYOrigin;
        copySheet.contentViewHeight     = self.contentViewHeight;
        copySheet.contentViewWidth      = self.contentViewWidth;
        copySheet.inlineCancelHandler   = self.inlineCancelHandler;
        copySheet.paddingOffset         = self.paddingOffset;
        copySheet.titleItemView         = [self.titleItemView copyWithZone:zone];
        copySheet.items                 = [self.items copyWithZone:zone];
        copySheet.itemViews             = [self.itemViews copyWithZone:zone];
        copySheet.cancelButtonTitle     = [self.cancelButtonTitle copyWithZone:zone];
    }
    
    return copySheet;
}

@end

//
//  BIPActionSheetItemViewTests.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 12/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BIPActionSheetItemView.h"
#import "BIPActionSheetItem.h"
#import "BIPActionSheetConstants.h"

@interface BIPActionSheetItemViewTests : XCTestCase

@property (nonatomic, copy) NSString *firstItemTitle;
@property (nonatomic, copy) NSString *secondItemTitle;
@property (nonatomic, strong) UIColor *firstItemTitleColor;

@property (nonatomic, strong) BIPActionSheetItem *itemWithTextColor;
@property (nonatomic, strong) BIPActionSheetItem *itemWithoutTextColor;



@end

@interface BIPActionSheetItemView (Testing)

@property (nonatomic, strong) UIImageView        *imageView;

@property (nonatomic, strong) UILabel            *itemLabel;
@property (nonatomic, strong) UILabel            *titleLabel;

@property (nonatomic, strong) UIButton           *button;
@property (nonatomic, strong) UIView             *lineView;
@property (nonatomic, strong) BIPActionSheetItem *item;
@property (nonatomic, strong) BIPActionSheet     *ownerActionSheet;

- (void)buttonTapped:(UIButton *)sender;

@end

@implementation BIPActionSheetItemViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [self initializeItems];
}

- (void)initializeItems {
    
    _firstItemTitle  = @"First";
    _secondItemTitle = @"Second";
    
    _firstItemTitleColor = [UIColor blueColor];
    
    _itemWithTextColor = [[BIPActionSheetItem alloc] initWithTitle:_firstItemTitle
                                                             image:nil
                                                         textColor:_firstItemTitleColor
                                                     actionHandler:^(BIPActionSheet *actionSheet) {
                                                         NSLog(@"Called Item With TextColor Handler");
                                                     }];
    
    _itemWithoutTextColor = [BIPActionSheetItem itemWithTitle:_secondItemTitle
                                                        image:nil
                                                actionHandler:^(BIPActionSheet *actionSheet) {
                                                    NSLog(@"Called Item Without TextColor Handler");
                                                }];
}

- (void)test_InitializeWithItem {
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    XCTAssertNotNil(itemView);
}

- (void)test_InitializeWithHeadLineItem {
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:YES ownerSheet:nil];
    XCTAssertNotNil(itemView);
}

- (void)test_ItemViewContaintsTitleLabelIfHeadline {
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:YES ownerSheet:nil];
    XCTAssertTrue([itemView.subviews containsObject:itemView.titleLabel]);
}

- (void)test_ItemViewNotContaintsTitleLabelIfHeadline {
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    XCTAssertTrue(![itemView.subviews containsObject:itemView.titleLabel]);
}

#pragma mark - Test Appearences

- (void)test_TitleTextColorAppearence {
    
    UIColor *titleColor = [UIColor yellowColor];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:YES ownerSheet:nil];

    [itemView setTitleTextColor:titleColor];
    
    XCTAssertTrue(CGColorEqualToColor(itemView.titleLabel.textColor.CGColor, titleColor.CGColor));
}

- (void)test_ItemTextColorAppearence {
    
    UIColor *itemColor = [UIColor blueColor];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView setItemTextColor:itemColor];
    
    XCTAssertTrue(CGColorEqualToColor(itemView.itemLabel.textColor.CGColor, itemColor.CGColor));
}

- (void)test_ItemTextColorAppearenceIfHeadline {
    
    // Should Be false because headline item doesnt have itemLabel
    
    UIColor *itemColor = [UIColor blueColor];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:YES ownerSheet:nil];
    
    [itemView setItemTextColor:itemColor];
    
    XCTAssertFalse(CGColorEqualToColor(itemView.itemLabel.textColor.CGColor, itemColor.CGColor));
}

- (void)test_ShouldHave_ItemTextColor_Not_AppearenceColor {
    
    // Should have color of which set while creating item as text color,
    // Appearence shouldn't work here because, developer has changed spesific item text color while initializing the item
    
    UIColor *itemColor = [UIColor yellowColor];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView setItemTextColor:itemColor];
    
    XCTAssertFalse(CGColorEqualToColor(itemView.itemLabel.textColor.CGColor, itemColor.CGColor));
}

- (void)test_ItemImageAlignmentAppearence {
    
    BIPActionSheetImageAllignment alignment = Right;
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:YES ownerSheet:nil];
    
    [itemView setImageAlignment:alignment];
    
    XCTAssertEqual(itemView.imageAlignment, alignment);
}

- (void)test_CancelButtonFont {
    
    UIColor *cancelColor = [UIColor yellowColor];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView setCancelButtonColor:cancelColor];
    
    XCTAssertEqual(itemView.cancelButtonColor, cancelColor);
}

- (void)test_CancelButtonColor {
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView setCancelButtonFont:font];
    
    XCTAssertEqual(itemView.cancelButtonFont, font);
}

- (void)test_ItemFont {
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView setItemFont:font];
    
    XCTAssertEqual(itemView.itemFont, font);
}

- (void)test_TitleFont {
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView setTitleFont:font];
    
    XCTAssertEqual(itemView.titleFont, font);
}

#pragma mark - Button Actions

- (void)test_ButtonActionShouldCallHandler {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should Call Handler On Dismiss"];
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithoutTextColor isHeadlineItem:NO ownerSheet:nil];
    
    [itemView.item setActionHandler:^(BIPActionSheet *actionSheet){
        
        [expectation fulfill];
    }];
    
    [itemView buttonTapped:nil];
    
    [self waitForExpectationsWithTimeout:kBIPActionSheetHideAnimationDuration handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

#pragma mark - Test Copy

- (void)test_CopyWithZone {
    
    BIPActionSheetItemView *itemView = [[BIPActionSheetItemView alloc] initWithItem:_itemWithTextColor isHeadlineItem:YES ownerSheet:nil];
    BIPActionSheetItem *copyItemView = [itemView copy];
    XCTAssertNotNil(copyItemView);
}

#pragma mark - Tear Down

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    _itemWithTextColor = nil;
    _itemWithoutTextColor = nil;
    _firstItemTitleColor = nil;
    _firstItemTitle = nil;
    _secondItemTitle = nil;
    
    [super tearDown];
}

#pragma mark - Performance

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

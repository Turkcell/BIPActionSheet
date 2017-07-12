//
//  BIPActionSheetItemTests.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 12/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BIPActionSheetItem.h"

@interface BIPActionSheetItemTests : XCTestCase

@property (nonatomic, copy) NSString *firstItemTitle;
@property (nonatomic, strong) UIImage *firstItemImage;
@property (nonatomic, copy) NSString *secondItemTitle;
@property (nonatomic, strong) UIImage *secondItemImage;
@property (nonatomic, strong) UIColor *firstItemTitleColor;

@property (nonatomic, strong) BIPActionSheetItem *firstItem;
@property (nonatomic, strong) BIPActionSheetItem *secondItem;

@end

@implementation BIPActionSheetItemTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [self initializeItems];
}

- (void)initializeItems {
    
    _firstItemTitle  = @"First";
    _secondItemTitle = @"Second";
    
    _firstItemImage  = [UIImage imageNamed:@""];
    _secondItemImage = [UIImage imageNamed:@""];
    
    _firstItemTitleColor = [UIColor blueColor];
    
    _firstItem = [[BIPActionSheetItem alloc] initWithTitle:_firstItemTitle
                                                     image:_firstItemImage
                                                 textColor:_firstItemTitleColor
                                             actionHandler:nil];
    
    _secondItem = [BIPActionSheetItem itemWithTitle:_secondItemTitle
                                              image:_secondItemImage
                                      actionHandler:nil];
}

- (void)test_InitWithTitleWithColor {
    
    XCTAssertNotNil(_firstItem);
}

- (void)test_InitWithTitle {
    
    BIPActionSheetItem *item = [[BIPActionSheetItem alloc] initWithTitle:_firstItemTitle
                                                     image:_firstItemImage
                                             actionHandler:nil];
    XCTAssertNotNil(item);
}

- (void)test_ItemWithClassMethod {
    
    XCTAssertNotNil(_secondItem);
}

- (void)test_ItemWithClassMethodWithColor {
    
    BIPActionSheetItem *item = [BIPActionSheetItem itemWithTitle:_secondItemTitle
                                                           image:_secondItemImage
                                                       textColor:[UIColor redColor]
                                                   actionHandler:nil];
    XCTAssertNotNil(item);
}

- (void)test_ItemTitle {
    
    XCTAssertEqual(_firstItemTitle, _firstItem.title);
}

- (void)test_ItemImage {
    
    XCTAssertEqual(_firstItemImage, _firstItem.image);
}

- (void)test_ItemTextColor {
    
    XCTAssertEqual(_firstItemTitleColor, _firstItem.textColor);
}

- (void)test_CopyWithZone {
    
    BIPActionSheetItem *copyItem = [_firstItem copy];
    XCTAssertNotNil(copyItem);
}

- (void)test_TitleEqualsWithCopy {
    
    BIPActionSheetItem *copyItem = [_firstItem copy];
    XCTAssertEqual(_firstItem.title, copyItem.title);
}

- (void)test_TextColorEqualsWithCopy {
    
    BIPActionSheetItem *copyItem = [_firstItem copy];
    XCTAssertEqual(_firstItem.textColor, copyItem.textColor);
}

- (void)test_ImageEqualsWithCopy {
    
    BIPActionSheetItem *copyItem = [_firstItem copy];
    XCTAssertEqual(_firstItem.image, copyItem.image);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _firstItem = nil;
    _secondItem = nil;
    _firstItemTitleColor = nil;
    _firstItemImage = nil;
    _firstItemTitle = nil;
    _secondItemImage = nil;
    _secondItemTitle = nil;
    
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

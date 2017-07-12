//
//  BIPActionSheetStackTests.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 12/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BIPActionSheetKit.h"

@interface BIPActionSheetStackTests : XCTestCase

@property (nonatomic, strong) BIPActionSheetStack *stack;

@end

@implementation BIPActionSheetStackTests

#pragma mark - Setup

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.stack = [BIPActionSheetStack sharedInstance];
}

#pragma mark - Methods

- (void)test_ContainsActionSheetInStack {
    
    BIPActionSheet *sheet = [BIPActionSheet showActionSheetWithItems:@[] cancelButtonTitle:@"Cancel" cancelHandler:nil];
    XCTAssertTrue([self.stack containsActionSheetInStack:sheet]);
}

#pragma mark - Tear Down

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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

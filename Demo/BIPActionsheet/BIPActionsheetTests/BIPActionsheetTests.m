//
//  BIPActionsheetTests.m
//  BIPActionsheetTests
//
//  Created by AHMET KAZIM GUNAY on 12/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BIPActionSheet.h"

@interface BIPActionsheetTests : XCTestCase

@end

@implementation BIPActionsheetTests

- (void)setUp {
    [super setUp];
    
}

- (void)testInitWithEmptyItems {
    
    BIPActionSheet *actionSheet = [[BIPActionSheet alloc] initWithItems:@[] cancelButtonTitle:@"Cancel" cancelHandler:nil];
    XCTAssertNotNil(actionSheet);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

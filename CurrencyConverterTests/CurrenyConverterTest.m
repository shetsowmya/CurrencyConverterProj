//
//  CurrenyConverterTest.m
//  CurrencyConverter
//
//  Created by Nidhi on 27/09/15.
//  Copyright © 2015 ShetCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface CurrenyConverterTest : XCTestCase

@end

@implementation CurrenyConverterTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    ViewController * vcToTest = [[ViewController alloc] init];
    
    BOOL result = [vcToTest validateUI];
    
    XCTAssertEqual(result, true);
    
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

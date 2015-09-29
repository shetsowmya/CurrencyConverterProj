//
//  CurrencyConverterTest.m
//  CurrencyConverter
//
//  Created by Nidhi on 29/09/15.
//  Copyright © 2015 ShetCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface CurrencyConverterTest : XCTestCase

@end

@implementation CurrencyConverterTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    ViewController * vctoTest = [[ViewController alloc] init];
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

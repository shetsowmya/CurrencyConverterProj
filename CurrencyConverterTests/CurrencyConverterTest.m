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
@property (nonatomic) ViewController *vcToTest;

@end

@implementation CurrencyConverterTest

- (void)setUp {
    [super setUp];
   // self.vcToTest = [[ViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    self.vcToTest = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//    
//
   [self.vcToTest loadView];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testViewControllerViewExists {
    XCTAssertNotNil([self.vcToTest view], @"ViewController should contain a view");
}

-(void)testAUDCurrencyTextFieldConnection {
    
    XCTAssertNotNil([self.vcToTest audCurrencyTxtFld],@"AUD inpt text feild should be connected");
}

-(void)testCurrecyPickerViewConnection {
    XCTAssertNotNil([self.vcToTest currencyPickerView], @"currency picker View should be connected");
}

-(void)testConvertedCurrencyTextFeildConnection {
    XCTAssertNotNil([self.vcToTest convertedCurrencyTxtFld], @"converted Currency Text Feild should be connected");
}

-(void)testConvertingCurrency{
    self.vcToTest.audCurrencyTxtFld.text = @"$4";
    [self.vcToTest pickerView:self.vcToTest.currencyPickerView didSelectRow:0 inComponent:0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

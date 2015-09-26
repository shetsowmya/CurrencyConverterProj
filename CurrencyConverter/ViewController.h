//
//  ViewController.h
//  CurrencyConverter
//
//  Created by Nidhi on 26/09/15.
//  Copyright © 2015 ShetCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, NSURLConnectionDataDelegate, NSURLSessionTaskDelegate>
@property (strong, nonatomic) IBOutlet UITextField *audCurrencyTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *convertedCurrencyTxtFld;

@property (strong, nonatomic) IBOutlet UIPickerView *currencyPickerView;
@property (strong, nonatomic) NSArray * currencyArray;
@property (strong, nonatomic) NSMutableDictionary * currencyDict;

@property (strong, nonatomic) NSURL * fixerIoUrl;


@end


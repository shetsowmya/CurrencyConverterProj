//
//  ViewController.m
//  CurrencyConverter
//
//  Created by Nidhi on 26/09/15.
//  Copyright © 2015 ShetCo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize audCurrencyTxtFld,currencyPickerView, currencyArray,fixerIoUrl,currencyDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    audCurrencyTxtFld.delegate = self;
    
    currencyPickerView.delegate = self;
    currencyDict = [[NSMutableDictionary alloc] init];

    currencyArray = [NSArray arrayWithObjects:@"CAD", @"EUR", @"GBP", @"JPY", @"USD", nil];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [self.currencyPickerView setTransform:rotate];
    
    
    
    CGRect frame = currencyPickerView.frame;
    frame.size.width = 50;
    frame.size.height = 216;
    frame.origin.x=90;
    frame.origin.y = 200;
    currencyPickerView.frame = frame;
    
    currencyPickerView.showsSelectionIndicator =YES;
    currencyPickerView.backgroundColor = [UIColor clearColor];
    //
    self.currencyPickerView.center = CGPointMake(160,75);
       // Do any additional setup after loading the view, typically from a nib.
    
    
    //return contents from URL
   
    [self getExchangeRates];
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [audCurrencyTxtFld setText:@"hi"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getExchangeRates
{
    NSURL * exchangeRatesURL = [NSURL URLWithString:@"http://api.fixer.io/latest?base=AUD"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:exchangeRatesURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          [self loadTableViewWithJSONObject:data];
                                      }];
    
    [dataTask resume];

}

//UITextFeildDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {

    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [currencyArray count];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CGRect rect = CGRectMake(0, 0, 120, 80);
    

    
   // UILabel *label = [[UILabel alloc]initWithFrame:rect];
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [label setTransform:rotate];
    label.text = [currencyArray objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:56.0];
    label.numberOfLines =3;
    label.backgroundColor = [UIColor clearColor];
    label.clipsToBounds = YES;
    
    pickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    pickerView.layer.borderWidth = 2;
    
    return label ;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString * selectedCurrency = [currencyArray objectAtIndex: row];
    
    float convertedCurrencyValue = [self.audCurrencyTxtFld.text floatValue] * [[currencyDict valueForKey:selectedCurrency] floatValue];
    [self.convertedCurrencyTxtFld setText:[NSString stringWithFormat:@"%f",convertedCurrencyValue]];
    
}


//nsURLSessionDataDelegate delegate methods



- (void)loadTableViewWithJSONObject:(NSData *) data
{
    NSDictionary *alldata =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary * rates = [alldata objectForKey:@"rates"];
    [currencyDict setObject:[rates objectForKey:@"CAD"] forKey:@"CAD"];
    [currencyDict setObject:[rates objectForKey:@"EUR"] forKey:@"EUR"];
    [currencyDict setObject:[rates objectForKey:@"GBP"] forKey:@"GBP"];
    [currencyDict setObject:[rates objectForKey:@"JPY"] forKey:@"JPY"];
    [currencyDict setObject:[rates objectForKey:@"USD"] forKey:@"USD"];

}


@end

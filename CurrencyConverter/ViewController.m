//
//  ViewController.m
//  CurrencyConverter
//
//  Created by Nidhi on 26/09/15.
//  Copyright © 2015 ShetCo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (Test)

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
    
    UITapGestureRecognizer * myGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
    [self.currencyPickerView addGestureRecognizer:myGR];
    
//    CGRect frame = currencyPickerView.frame;
//    frame.size.width = 50;
//    frame.size.height = 216;
//    frame.origin.x=90;
//    frame.origin.y = 200;
//    currencyPickerView.frame = frame;
//    

    currencyPickerView.showsSelectionIndicator =YES;
   // currencyPickerView.backgroundColor = [UIColor clearColor];
    //
    self.currencyPickerView.center = CGPointMake(160,75);
       // Do any additional setup after loading the view, typically from a nib.
    
    //return contents from URL
    [self getExchangeRates];
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [currencyPickerView selectRow:2 inComponent:0 animated:YES];
    [currencyPickerView setBackgroundColor:[UIColor colorWithRed:0 green:102 blue:51 alpha:0.10]];
    
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
                                          [self loadPickerViewWithJSONObject:data];
                                      }];
    
    [dataTask resume];

}

//UITextFeildDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.audCurrencyTxtFld.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    if ((textField == self.audCurrencyTxtFld) && (textField.text.length !=0)) {
        if ([self.audCurrencyTxtFld.text substringFromIndex:1].length != 0 ) {
            self.currencyPickerView.userInteractionEnabled = YES;
        }
        else{
            self.currencyPickerView.userInteractionEnabled = NO;
            self.convertedCurrencyTxtFld.text = @"";
        }
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ((textField == self.audCurrencyTxtFld) && (textField.text.length !=0)) {
        if ([self.audCurrencyTxtFld.text substringFromIndex:1].length != 0 ) {
            self.currencyPickerView.userInteractionEnabled = YES;
        }
        else{
            self.currencyPickerView.userInteractionEnabled = NO;
            self.convertedCurrencyTxtFld.text = @"";
        }
    }
}
//UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {

    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [currencyArray count];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CGRect rect = CGRectMake(0, 0, 200, 150);
    
   // UILabel *label = [[UILabel alloc]initWithFrame:rect];
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [label setTransform:rotate];
    label.text = [currencyArray objectAtIndex:row];
    
    label.font = [UIFont fontWithName:@"Helvetica" size:56];
    [label setFont:[UIFont boldSystemFontOfSize:56]];

    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines =3;
    label.clipsToBounds = YES;
    [label setTextColor:[UIColor whiteColor]];
    
  
    //creating keyboard of type NumberOnly to input AUD value
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidPressed:)];
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [self toolbarHeight])];
    
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    self.audCurrencyTxtFld.inputAccessoryView = toolbar;
    
    return label ;
}


- (void)doneButtonDidPressed:(id)sender {
    [self.audCurrencyTxtFld resignFirstResponder];
}

-(CGFloat)toolbarHeight {
    // This method will handle the case that the height of toolbar may change in future iOS.
    return 44.f;
}


- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString * selectedCurrency = [currencyArray objectAtIndex: row];
    
    float convertedCurrencyValue = [[self.audCurrencyTxtFld.text substringFromIndex:1] floatValue] * [[currencyDict valueForKey:selectedCurrency] floatValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    if ([selectedCurrency isEqualToString:@"CAD"]) {
        numberFormatter.currencyCode = @"CAD";
    }else if([selectedCurrency isEqualToString:@"EUR"]){
        numberFormatter.currencyCode = @"EUR";
        
    }else if([selectedCurrency isEqualToString:@"GBP"]){
        numberFormatter.currencyCode = @"GBP";
        
    }else if([selectedCurrency isEqualToString:@"JPY"]){
        numberFormatter.currencyCode = @"JPY";
        
    }else if([selectedCurrency isEqualToString:@"USD"]){
        numberFormatter.currencyCode = @"USD";
    }
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:convertedCurrencyValue]];
    [self.convertedCurrencyTxtFld setText:[NSString stringWithFormat:@"%@",numberAsString]];
    
}


-(NSNumber *) calculateConvertedCurrencyValueForCurrencyCode:(NSString *)selectedCurrency
{

    NSMutableDictionary * tempDict = [[NSMutableDictionary alloc]init];
    [tempDict setObject:@"0.93449" forKey:@"CAD"];
    [tempDict setObject:@"0.62629" forKey:@"EUR"];
    [tempDict setObject:@"0.46045" forKey:@"GBP"];
    [tempDict setObject:@"84.005" forKey:@"JPY"];
    [tempDict setObject:@"0.69957" forKey:@"USD"];
    
    float convertedCurrencyValue = [self.audCurrencyTxtFld.text floatValue] * [[tempDict valueForKey:selectedCurrency] floatValue];    
   
    return [NSNumber numberWithFloat:convertedCurrencyValue];

}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

//parsing through the JSON Object to fill the currency dictionary
- (void)loadPickerViewWithJSONObject:(NSData *) data
{
    NSDictionary *alldata =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary * rates = [alldata objectForKey:@"rates"];
    [currencyDict setObject:[rates objectForKey:@"CAD"] forKey:@"CAD"];
    [currencyDict setObject:[rates objectForKey:@"EUR"] forKey:@"EUR"];
    [currencyDict setObject:[rates objectForKey:@"GBP"] forKey:@"GBP"];
    [currencyDict setObject:[rates objectForKey:@"JPY"] forKey:@"JPY"];
    [currencyDict setObject:[rates objectForKey:@"USD"] forKey:@"USD"];

}



// target method

-(void)pickerTapped:(id)sender
{
    CGFloat rowHeight = [self.currencyPickerView rowSizeForComponent:0].height;
    CGRect selectedRowFrame = CGRectInset(self.currencyPickerView.bounds, 0.0, (CGRectGetHeight(self.currencyPickerView.frame) - rowHeight) / 2.0 );
    BOOL userTappedOnSelectedRow = (CGRectContainsPoint(selectedRowFrame, [sender locationInView:self.currencyPickerView]));
    if (userTappedOnSelectedRow) {
        NSInteger selectedRow = [self.currencyPickerView selectedRowInComponent:0];
        [self pickerView:self.currencyPickerView didSelectRow:selectedRow inComponent:0];
    }
}

//method to be called for the UI to verify that when there is an amount specified in the AUD field, and the user selects a currency, the field at the bottom displays a figure.

-(NSNumber *)validateUI:(NSString *)audValue forCurrencyCode:(NSString *)selectedCurrencyCode
{
    self.audCurrencyTxtFld.text = audValue;
    NSNumber * convertedCurrencyValue = [self calculateConvertedCurrencyValueForCurrencyCode:selectedCurrencyCode];
    
    self.convertedCurrencyTxtFld.text = [convertedCurrencyValue stringValue];
    
    return convertedCurrencyValue;
}


@end

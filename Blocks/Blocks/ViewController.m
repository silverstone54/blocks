//
//  ViewController.m
//  Blocks
//
//  Created by User on 01.03.17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ViewController.h"
#import "FSArray.h"

@interface ViewController ()

@end

@implementation ViewController
{
    FSArray *fsArray;
    UIAlertController *alert;
}

const NSInteger ARRAY_INDEX = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FSDataProvider dataProviderAction =
    ^{
        NSArray *array = [[NSArray alloc] init];
        array = @[@"a", @"b", @"c", @"a", @"e", @"c", @"a"];
        
        return array;
    };
    
    fsArray = [[FSArray alloc] initWithDataProvider:dataProviderAction];
    [self createAlertController];
}

- (IBAction)populateButtonAction:(id)sender
{
    [fsArray populate];
}

- (IBAction)enumerateButtonAction:(id)sender
{
    __weak typeof(self) weakSelf = self;
    void (^enumerator)(NSInteger) = ^(NSInteger counter)
    {
        [weakSelf showAlertWithMessage:[NSString stringWithFormat:@"%ld", counter]];
    };
    [fsArray enumerateItems:enumerator];
    fsArray.enumerationCompleteHandler();
}

- (IBAction)itemAtIndexButtonAction:(id)sender
{
    __weak typeof(self) weakSelf = self;
    void (^showAlertAction)(NSString *) = ^(NSString *string)
    {
        [weakSelf showAlertWithMessage:string];
    };
    [fsArray asyncItemAtIndex:ARRAY_INDEX andShowAlertUsingBlock:showAlertAction];
}

- (void)createAlertController
{
    alert = [UIAlertController alertControllerWithTitle:@"Result" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alert addAction:okAction];
}

- (void)showAlertWithMessage:(NSString *)message
{
    alert.message = message;
    [self presentViewController:alert animated:YES completion:nil];
}

@end

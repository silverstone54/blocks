//
//  FSArray.m
//  Blocks
//
//  Created by User on 01.03.17.
//  Copyright © 2017 User. All rights reserved.
//

#import "FSArray.h"

@implementation FSArray
{
    NSArray *array;
    FSDataProvider dataProviderHandler;
}

- (instancetype)initWithDataProvider:(FSDataProvider)dataProvider
{
    self = [super init];
    if( self )
    {
        dataProviderHandler = dataProvider;
    }
    return self;
}

- (void)populate
{
    array = dataProviderHandler();
}

- (void)enumerateItems:(void (^)(NSInteger))enumerator
{
    __block int counter = 0;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        counter++;
    }];
    self.enumerationCompleteHandler = ^
    {
        enumerator(counter);
    };
}

- (void)asyncItemAtIndex:(NSInteger)index andShowAlertUsingBlock:(void (^)(NSString *))showAlertAction
{
    int seconds = arc4random_uniform(3) + 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        showAlertAction(array[index]);
    });
}

@end

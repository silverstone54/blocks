//
//  FSArray.h
//  Blocks
//
//  Created by User on 01.03.17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "BlocksTypedefs.h"

@interface FSArray : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataProvider:(FSDataProvider)dataProvider;

- (void)populate;
- (void)enumerateItems:(void (^)(NSInteger))enumerator;
- (void)asyncItemAtIndex:(NSInteger)index andShowAlertUsingBlock:(void (^)(NSString *))showAlertAction;

@property (nonatomic, copy) void (^enumerationCompleteHandler)(void);

@end

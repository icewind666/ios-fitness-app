//
//  AccelSeries.h
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 08.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimedAccelValue.h"

@interface AccelSeries : NSObject

@property (strong, nonatomic) NSMutableArray *values;

// Returns values arrived in given seconds starting from given date
- (NSArray *) valuesForSeconds: (int) seconds startingFrom: (NSDate *) date;
- (NSMutableArray *) allValues;
- (void) addValue : (TimedAccelValue *)value;

@end

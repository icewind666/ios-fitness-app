//
//  TimedAccelValue.h
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 08.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimedAccelValue : NSObject

@property (weak, nonatomic) NSDate *dateStamp;
@property (nonatomic) double value;
@property (nonatomic) int signMultiplier;

+(id) value : (double) v withDate:(NSDate *)dateValue andSign:(int)sign;
-(NSString *) toString;

@end

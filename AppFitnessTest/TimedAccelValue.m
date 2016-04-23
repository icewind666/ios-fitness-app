//
//  TimedAccelValue.m
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 08.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import "TimedAccelValue.h"

@implementation TimedAccelValue

@synthesize value;
@synthesize dateStamp;
@synthesize signMultiplier;


//
// Creates new timed acceleration value
//
+(id) value : (double) v withDate:(NSDate *)dateValue andSign:(int)sign{
    TimedAccelValue *inst = [[TimedAccelValue alloc] init];
    inst.value = v;
    inst.dateStamp = dateValue;
    inst.signMultiplier = sign;
    
    return inst;
}


//
// Returns string representation of timed acceleration value
//
-(NSString *) toString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateString = [formatter stringFromDate:self.dateStamp];
    NSString *result = [NSString stringWithFormat:@"[%@; %.3f]", dateString, self.value * self.signMultiplier];
    return result;
}

@end

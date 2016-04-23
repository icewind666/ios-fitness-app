//
//  AccelSeries.m
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 08.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import "AccelSeries.h"
#import "TimedAccelValue.h"
          
@implementation AccelSeries

@synthesize values;

-(NSArray *) valuesForSeconds:(int)seconds startingFrom:(NSDate *)date {
    if(date == nil)
    {
        date = ((TimedAccelValue *)[values firstObject]).dateStamp;
    }
    
    NSDate *endDate = [date dateByAddingTimeInterval:seconds];
    
    NSMutableArray *series = [[NSMutableArray alloc] init];
    
    for (TimedAccelValue *timedValue in values) {
        if(timedValue.dateStamp > endDate) {
            break;
        }
        
        if(timedValue.dateStamp >= date) {
            // found starting point
            [series addObject:timedValue];
        }
    }
    
    return series;
}

-(void) addValue:(TimedAccelValue *)value {
    if(self.values == nil) {
        self.values = [[NSMutableArray alloc] init];
    }
    [self.values addObject:value];
}

-(NSMutableArray *) allValues {
    return self.values;
}


@end

//
//  SeriesDetector.m
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 08.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import "SeriesDetector.h"
#import "AccelSeries.h"
#import "TimedAccelValue.h"

@implementation SeriesDetector


@synthesize pullUpAmplifyThreshold;
@synthesize pullUpLonginessInSeconds;
@synthesize ignoreValuesAbsThreshold;

@synthesize dataSeries;

+(id) SeriesDetector: (AccelSeries *) data withAmplifyThreshold:(double)threshold andTimeLonginess:(double)time {
    SeriesDetector *nDetector = [[SeriesDetector alloc] init];
    nDetector.pullUpAmplifyThreshold = threshold;
    nDetector.pullUpLonginessInSeconds = time;
    
    nDetector.ignoreValuesAbsThreshold = 0.09f;
    nDetector.dataSeries = data;
    return nDetector;
}

-(int) countOfPullUpsDetected {
    NSArray *values = [dataSeries allValues];
    
    BOOL upperMoveDetected = NO;
    BOOL downMoveDetected = NO;
    BOOL upGravityDetected = NO;
    BOOL downGravityDetected = NO;
    BOOL upperToDownChangeDetected = NO;
    
    BOOL processingUpMove = NO;
    BOOL processingDownMove = NO;
    
    
    
    BOOL seriesProcessing = NO;
    
    int stopValuesNumberInCurrentSeries = 0;
    
    NSMutableArray *tempUpSeries = [[NSMutableArray alloc] init];
    NSMutableArray *tempDownSeries = [[NSMutableArray alloc] init];
    
    
    // detecting upper move. gravity must be positive
    for (TimedAccelValue *timedValue in values) {
        //NSLog(@"v = %.3f", timedValue.value);
        
        // got zero
        if([self shouldIgnoreValue:timedValue.value]) {
            
            if (processingUpMove) {
            
                
                continue;
            }
            
            if (processingDownMove) {
                NSLog(@"%.3f -> ZERO AFTER DOWN MOVE", timedValue.value);
                continue;
            }
            
            // no moves until here.
            
            //NSLog(@"%.3f -> ZERO", timedValue.value);
            processingUpMove = YES;

            continue;
        }
        
        
        
        
        if (timedValue.signMultiplier < 0) {
            // ok we are going up
            NSLog(@"%.3f -> going UP!", timedValue.value);
            
            //if (processingDownMove) {
            //    NSLog(@"WTF? we were going down! now upping");
                
            //}
            
            processingUpMove = YES;
            [tempUpSeries addObject:timedValue];
        }
        else
        {
            // breaking chain. we are going down??
            NSLog(@"%.3f -> going DOWN!", timedValue.value);
            [tempDownSeries addObject:timedValue];
            processingDownMove = YES;
            
            
        }
        
        
    }
    
    
    

    return 0;
}


-(BOOL) shouldIgnoreValue : (double) value {
    
    if(fabs(value) < self.ignoreValuesAbsThreshold)
        return YES;
    else
        return NO;
}











@end

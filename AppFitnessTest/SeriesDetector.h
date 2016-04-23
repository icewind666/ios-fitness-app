//
//  SeriesDetector.h
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 08.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccelSeries.h"

@interface SeriesDetector : NSObject

@property (nonatomic, strong) AccelSeries *dataSeries;

@property (nonatomic) double pullUpAmplifyThreshold;

@property (nonatomic) double pullUpLonginessInSeconds;

@property (nonatomic) double ignoreValuesAbsThreshold;

-(int) countOfPullUpsDetected;
+(id) SeriesDetector: (AccelSeries *) data withAmplifyThreshold:(double)threshold andTimeLonginess:(double)time;

@end

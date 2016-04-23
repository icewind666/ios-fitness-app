//
//  ViewController.h
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 05.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

#import "SeriesDetector.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *signLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CMMotionManager *motionManager;

@property (nonatomic, weak) NSMutableArray *dataValues;
@property (weak, nonatomic) IBOutlet UILabel *axisSelected;

@property (nonatomic, strong) SeriesDetector *detector;
@property (nonatomic) bool upMoveDetected;
@property (nonatomic) int pullUpsCounter;
@end


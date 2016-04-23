//
//  ViewController.m
//  AppFitnessTest
//
//  Created by Vladimir Korennoy on 05.11.14.
//  Copyright (c) 2014 iAge. All rights reserved.
//

#import "ViewController.h"
#import "SeriesDetector.h"
#import "TimedAccelValue.h"
#import "AccelSeries.h"
#import <AudioToolbox/AudioToolbox.h>

#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()
    
@end

@implementation ViewController

@synthesize signLabel;
@synthesize dataValues;
@synthesize axisSelected;

double currentMaxAccelX;
double prevValue;
double currentDelta;

@synthesize upMoveDetected;

double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;
int restCounter;

@synthesize detector;
@synthesize pullUpsCounter;

SystemSoundID mBeep;
bool isAccelerometerOn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    restCounter = 0;
    isAccelerometerOn = NO;
    pullUpsCounter = 0;
}


-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    if(self.upMoveDetected)
        self.axisSelected.text = @"UP MOVE WAS DETECTED. WAIT FOR DOWN";
    else
        self.axisSelected.text = @"WAIT FOR UP MOVE";
    
    // todo: choose axis
    double vValue = acceleration.z;
    
    if ((vValue + 1 < -0.2) && upMoveDetected) {
            NSLog(@"%.2f = DOWN", (vValue + 1));
            NSLog(@"PULL UP DETECTED!!!!");
            self.pullUpsCounter++;
            self.signLabel.text = [NSString stringWithFormat:@"%i", self.pullUpsCounter];
            upMoveDetected = NO;
            AudioServicesPlaySystemSound(1306);
    }
    
    if ((vValue + 1 > 0.2) && !upMoveDetected) {
            NSLog(@"%.2f = UP", (vValue + 1));
            upMoveDetected = YES;
    }
    
    if (vValue + 1 <= 0.2 && vValue >= -0.2) {
        if(restCounter > 3) {
            upMoveDetected = NO;
            restCounter = 0;
        }
        else {
            restCounter++;
        }
        
        
    }
    
    if(self.upMoveDetected)
        self.axisSelected.text = @"UP WAS. WAIT FOR DOWN";
    else
        self.axisSelected.text = @"WAIT FOR UP";
}


-(void)outputRotationData:(CMRotationRate)rotation
{
//    self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
}


- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 1; // meters
    
    NSLog(@"starting gps...");
    self.locationManager.activityType = CLActivityTypeFitness;
    
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
    
    [self.locationManager startUpdatingLocation];
}


// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"locations..");
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude, location.altitude);
        
}


- (IBAction)setAccelerometerOn:(id)sender {
    
    if(isAccelerometerOn) {
        [self.motionManager stopAccelerometerUpdates];
    }
    else {
        isAccelerometerOn = YES;
        if(self.motionManager == nil) {
            self.motionManager = [[CMMotionManager alloc] init];
        }
        
        self.motionManager.accelerometerUpdateInterval = .2;
        
        //self.motionManager.gyroUpdateInterval = .2;
    
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 
                                                 if(error){
                                                     NSLog(@"%@", error);
                                                 }
                                             }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)playSuccessSound
//{
//    NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/genericsuccess.wav"];
//    SystemSoundID soundID;
//    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
//    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(filePath), &soundID);
//    AudioServicesPlaySystemSound(soundID);
//    
//    //also vibrate
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//}

@end

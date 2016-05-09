//
//  Weather.h
//  Forecaster
//
//  Created by MBPinTheAir on 08/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentForecast.h"
#import <CoreLocation/CoreLocation.h>


@protocol LocationDelegate<NSObject>

-(void)loadCity;

@end
@interface Location : NSObject
@property  (nonatomic, weak)id<LocationDelegate>delegate;
@property (copy, nonatomic) NSString *cityName;  //userinput
@property (assign, nonatomic) CLLocationCoordinate2D coordinates;
@property (strong, nonatomic ) CurrentForecast *currently;

- (void)coordsForAddress;

@end

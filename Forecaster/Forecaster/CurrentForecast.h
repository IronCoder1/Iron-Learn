//
//  CurrentForecast.h
//  Forecaster
//
//  Created by MBPinTheAir on 08/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentForecast : NSObject
@property (copy, nonatomic) NSString * summary;

@property (copy, nonatomic) NSString * icon;
@property (strong, nonatomic) NSNumber *temperature;
@property (copy, nonatomic) NSString * visibility;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber * pressure;

@end

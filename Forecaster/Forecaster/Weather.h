//
//  Weather.h
//  Forecaster
//
//  Created by MBPinTheAir on 08/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentForecast.h"

@interface Weather : NSObject

@property (assign, nonatomic) NSNumber *latitude;
@property (assign, nonatomic) NSNumber *longitude;
@property (strong, nonatomic ) CurrentForecast *currently;

@end

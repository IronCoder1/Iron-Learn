//
//  DailyForecast.h
//  Forecaster
//
//  Created by MBPinTheAir on 10/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyForecast : NSObject


@property (copy, nonatomic) NSString *dailySummary;
@property (copy, nonatomic) NSString *dailyIcon;

@property (copy, nonatomic) NSString  *sunriseTime;
@property (copy, nonatomic) NSString  *sunsetTime;
@property (copy, nonatomic) NSString   *day;
@property (copy, nonatomic) NSString *weeklySummary;


@end


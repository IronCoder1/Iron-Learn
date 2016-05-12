//
//  DetailForecastViewController.h
//  Forecaster
//
//  Created by MBPinTheAir on 10/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "CurrentForecast.h"
#import "WeeklyForecastTViewController.h"

@interface DetailForecastViewController : UIViewController
@property (strong, nonatomic) Location *holdingLocationDFVC;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *windspeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;




@end

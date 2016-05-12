//
//  WeeklyForecastTViewController.h
//  Forecaster
//
//  Created by MBPinTheAir on 10/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface WeeklyForecastTViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) Location *holdingLocWTVC;
@property (strong, nonatomic) NSMutableArray *arrayWithWeeklyData;

@end

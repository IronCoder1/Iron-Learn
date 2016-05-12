//
//  CellViewWeekly.h
//  Forecaster
//
//  Created by MBPinTheAir on 10/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewWeekly : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklySummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;

@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;


@end

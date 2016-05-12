//
//  WeeklyForecastTViewController.m
//  Forecaster
//
//  Created by MBPinTheAir on 10/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "WeeklyForecastTViewController.h"
#import "CellViewWeekly.h"
#import "DailyForecast.h"

@interface WeeklyForecastTViewController ()

@end

@implementation WeeklyForecastTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.arrayWithWeeklyData  = [[NSMutableArray alloc]init ];

    
   // [self.arrayWithWeeklyData addObjectsFromArray:self.holdingLocWTVC.oneWeekPerCityObject.weekDataArray];
    
    NSLog(@"%@", self.arrayWithWeeklyData);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayWithWeeklyData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewWeekly *cell = (CellViewWeekly *) [tableView dequeueReusableCellWithIdentifier:@"oneWeekCell" forIndexPath:indexPath];
    
    DailyForecast *dailyObj = self.arrayWithWeeklyData[indexPath.row];
    
    for (dailyObj in self.arrayWithWeeklyData){
 
        
//    double day = [dailyObj.day doubleValue];
//    NSDate *date = [[NSDate alloc]init];
//    [date timeIntervalSinceDate:day];
    
    cell.dayLabel.text = dailyObj.day;
    cell.sunriseLabel.text = dailyObj.sunriseTime;
    cell.sunsetLabel.text = dailyObj.sunsetTime;
    cell.weeklySummaryLabel.text = dailyObj.weeklySummary;
        
    }
    
//    double sunriseTime = [dailyObj.sunriseTime doubleValue];
//    double sunsetTime = [dailyObj.sunsetTime doubleValue];
//    
        return cell;
}


/*
 
 WeekData *dailyData = self.daysArray[indexPath.row];
 
 int day = [dailyData.day intValue];
 int minTemp = [dailyData.minTemp intValue];
 int maxTemp = [dailyData.maxTemp intValue];
 
 NSDate *day2 = [[NSDate alloc] initWithTimeIntervalSince1970:day];
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 [formatter setDateStyle:NSDateFormatterLongStyle];
 NSString *dateString = [formatter stringFromDate:day2];
 
 
 cell.dateLabel.text = dateString;
 cell.summaryWeatherLabel.text = self.citySelected.dailyWeatherForecast.summary;
 cell.minTempLabel.text = [NSString stringWithFormat:@"%d F°", minTemp];
 cell.maxTempLabel.text = [NSString stringWithFormat:@"%d F°", maxTemp];
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

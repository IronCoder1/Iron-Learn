//
//  DetailForecastViewController.m
//  Forecaster
//
//  Created by MBPinTheAir on 10/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "DetailForecastViewController.h"


@interface DetailForecastViewController ()
@property (strong, nonatomic) NSMutableArray *weeklyWeatherArray;
@end

@implementation DetailForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =[NSString stringWithFormat:@"Detail Weather Forecast for %@", self.holdingLocationDFVC.cityName];
    self.summaryLabel.text = self.holdingLocationDFVC.currently.summary;
    self.windspeedLabel.text = [NSString stringWithFormat:@"Wind Speed is currently %@",self.holdingLocationDFVC.currently.windSpeed];
    self.visibilityLabel.text = [NSString stringWithFormat:@"The visibility is %@",self.holdingLocationDFVC.currently.visibility];
    self.humidityLabel.text = [NSString stringWithFormat:@"Humidity stands at %@",self.holdingLocationDFVC.currently.humidity];
    self.pressureLabel.text = [NSString stringWithFormat:@"Atmospheric pressure is at %@",self.holdingLocationDFVC.currently.pressure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Navigation

// detailed forecast information about the current weather as well as provide a button to show the forecast for the next week.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     NSMutableArray *weeklyWeatherArray = [[NSMutableArray alloc]initWithCapacity:0];
    if ([segue.identifier isEqualToString:@"ToOneWeekSegue"]) {
       WeeklyForecastTViewController *weeklyVC = (WeeklyForecastTViewController *)[segue destinationViewController];
        
        
        
//        Location  *locObject = [self.weeklyWeatherArray ob];
//        
//        weeklyVC.holdingLocationDFVC  = locObject;
        
        weeklyVC.arrayWithWeeklyData = self.weeklyWeatherArray;
     
         
        NSString *darkSkyUrl = [NSString stringWithFormat:@"https://api.forecast.io/forecast/92c99d3c6e34eb5b41149178890b6c02/%f,%f",_holdingLocationDFVC.coordinates.latitude, _holdingLocationDFVC.coordinates.longitude];
         
         NSURLSession *session = [NSURLSession sharedSession];
         
         NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:darkSkyUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
         {
         NSError *jsonerror;
         NSMutableDictionary *mainForecastDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &jsonerror];
         if (!error){
             
             NSDictionary *dailyDict = mainForecastDict[@"daily"];
            
         NSArray *dailyDataArray = dailyDict[@"data"];
         for (NSDictionary *loopDict in dailyDataArray){
         DailyForecast *dailyWeatherObj = [[DailyForecast alloc]init];
         
         dailyWeatherObj.sunriseTime = loopDict[@"sunriseTime"];
         dailyWeatherObj.sunsetTime = loopDict[@"sunsetTime"];
         dailyWeatherObj.day = loopDict[@"time"];
         dailyWeatherObj.dailyIcon = loopDict[@"icon"];
         dailyWeatherObj.dailySummary = loopDict[@"summary"];
         dailyWeatherObj.weeklySummary = dailyDict[@"summary"];
         [weeklyWeatherArray addObject:dailyWeatherObj];
         }
             
         }
         dispatch_async(dispatch_get_main_queue(), ^{ });
         }
         
         ];
         [jsonData resume];
         

}
 

}

@end

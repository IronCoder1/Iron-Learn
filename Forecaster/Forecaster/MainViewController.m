//
//  MainViewController.m
//  Forecaster
//
//  Created by MBPinTheAir on 08/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "MainViewController.h"
#import "Weather.h"
#import "CurrentForecast.h"
#import "CellView.h"
#import "LocationManager.h"

@interface MainViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *weatherArray;
@property (nonatomic, strong) LocationManager *locMgr;
- (IBAction)enterCity:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weatherArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.title = @"Current Weather";
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self getWeatherJSON];
    
    LocationManager *locMgr = [[LocationManager alloc]init];
   [locMgr coordsForAddress];
    
    
}


//- (void)coordsForAddress {
//    
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    
//    [geoCoder geocodeAddressString:[NSString stringWithFormat:self.cityEntered]completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        CLPlacemark *placemark = placemarks[0];
//        NSLog(@"Lat: %f, Long: %f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
//        
//    }];
//}


-(void)getWeatherJSON{
    
 NSString *darkSkyUrl = @"https://api.forecast.io/forecast/92c99d3c6e34eb5b41149178890b6c02/37.8267,-122.423";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSError *error;
    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:darkSkyUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
        NSArray *weatherJSONarray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        if (!error){
            
            for (NSMutableDictionary *dict in weatherJSONarray){
                
                Weather *weatherObject = [[Weather alloc]init];
                
                weatherObject.longitude = dict[@"longitude"];
                weatherObject.latitude = dict[@"latitude"];
                
                
                CurrentForecast *theCurrentForecastObject = [[CurrentForecast alloc]init];
                
                 theCurrentForecastObject.summary = dict[@"currently"][@"summary"];
                 theCurrentForecastObject.temperature = dict[@"currently"][@"temperature"];
                
                weatherObject.currently = theCurrentForecastObject;
                
                [self.weatherArray addObject:weatherObject];
                
                NSLog(@"%@ summanry", theCurrentForecastObject.summary);
                
            }
           // dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
        }
    
    }];
    [jsonData resume];
    
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
    return [self.weatherArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellView *cell = (CellView *)[tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
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

- (IBAction)enterCity:(id)sender {
    
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Get Weather" message:@"Please enter the city" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      
        UITextField *city = myAlert.textFields[0];
        
        self.cityEntered = city.text;
        
        NSLog(@"The city is %@", self.cityEntered);
    
    }];

    // instansiate cancel button using blocks
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [myAlert addAction:ok];
    [myAlert addAction:cancel];
    
    [myAlert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
        textField.placeholder = @"City...";
    }];
    
    [self presentViewController:myAlert animated:YES completion:nil];
    
    

}

//-(void)addCity:(id)sender{
//    NSMutableArray *cityArray = [[NSMutableArray alloc]initWithCapacity:0];
//
//    
//}
@end

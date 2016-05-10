//
//  MainViewController.m
//  Forecaster
//
//  Created by MBPinTheAir on 08/05/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "MainViewController.h"
#import "CurrentForecast.h"
#import "CellView.h"

@interface MainViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *locationArray;

- (IBAction)enterCity:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.locationArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.title = @"Current Weather";
}

//-(void)getWeatherJSON{
//    
//    
//}

//-(void)loadCity{
//
//    [self getWeatherJSON];
//
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locationArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellView *cell = (CellView *)[tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
    
    //NSUInteger row = indexPath.row;
    Location *thisLocationObject = self.locationArray[indexPath.row];
    cell.cityLabel.text = thisLocationObject.cityName;
    cell.cityLabel.font = [UIFont fontWithName:@"Menlo" size:12];
    cell.cityLabel.textColor = [UIColor blueColor];
   
    cell.tempLabel.text = [NSString stringWithFormat:@" %@", thisLocationObject.currently.temperature];
    cell.tempLabel.font = [UIFont fontWithName:@"Menlo" size:22];
    cell.tempLabel.textColor = [UIColor redColor];
    
    cell.currWeatherLabel.font = [UIFont fontWithName:@"helvetica" size:17];
    cell.currWeatherLabel.text = thisLocationObject.currently.summary;

    
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
 
 
 - (void)coordsForAddress {

 
 [self.delegate loadCity];
 
 
 }];
 }
*/

- (IBAction)enterCity:(id)sender {
    
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Get Weather" message:@"Please enter the city" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      
    UITextField *city = myAlert.textFields[0];
    Location *locObj = [[Location alloc] init];
        //assign text to location object
    locObj.cityName = city.text;
        // add object to array
        [self.locationArray addObject:locObj];
        
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder geocodeAddressString:locObj.cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error){
    CLPlacemark *placemark = placemarks[0];
            NSLog(@"Lat: %f, Long: %f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
    locObj.coordinates = CLLocationCoordinate2DMake (placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
        
        //Perform an asynchronous network call to ask the Forecast.io weather API for weather info on each location in the list.
       
        NSString *darkSkyUrl = [NSString stringWithFormat:@"https://api.forecast.io/forecast/92c99d3c6e34eb5b41149178890b6c02/%f,%f",locObj.coordinates.latitude, locObj.coordinates.longitude];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:darkSkyUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
                      NSError *jsonerror;
                      NSMutableDictionary *weatherJSONdict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &jsonerror];
                            if (!error){
                             CurrentForecast *theCurrentForecastObject = [[CurrentForecast alloc]init];
                                theCurrentForecastObject.summary = weatherJSONdict[@"currently"][@"summary"];
                                theCurrentForecastObject.temperature = weatherJSONdict[@"currently"][@"temperature"];
                                                  
                                locObj.currently = theCurrentForecastObject;
                    NSLog(@"%@ summanry", theCurrentForecastObject.summary);
                                
                           }
                dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
         }
                                          
                                          ];
        [jsonData resume];

        
    
}];
        NSLog(@"The city is %@", locObj.cityName);
    
    }];
        
    
    // instansiate cancel button using blocks
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    
    [myAlert addAction:ok];
    [myAlert addAction:cancel];
    
    [myAlert addTextFieldWithConfigurationHandler:^(UITextField * textField) {textField.placeholder = @"City..."; }];
    
    [self presentViewController:myAlert animated:YES completion:nil];
    
}
                        
                         


@end

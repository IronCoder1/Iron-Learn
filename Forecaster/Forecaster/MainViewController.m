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

@interface MainViewController ()<UITextFieldDelegate, LocationDelegate>
@property (strong, nonatomic) NSMutableArray *locationArray;

- (IBAction)enterCity:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Current Weather";
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}




-(void)getWeatherJSON{
    
 NSString *darkSkyUrl = @"https://api.forecast.io/forecast/92c99d3c6e34eb5b41149178890b6c02/";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:darkSkyUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
                                         NSError *jsonerror;
        NSMutableDictionary *weatherJSONdict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &jsonerror];
            if (!error){
                
                CurrentForecast *theCurrentForecastObject = [[CurrentForecast alloc]init];
                
                 theCurrentForecastObject.summary = weatherJSONdict[@"currently"][@"summary"];
                 theCurrentForecastObject.temperature = weatherJSONdict[@"currently"][@"temperature"];
                
                
                
//                locationObject.currently = theCurrentForecastObject;
                
                
                NSLog(@"%@ summanry", theCurrentForecastObject.summary);
                
            }
              dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
        }
    
    ];
    [jsonData resume];
    
}

-(void)loadCity{

    [self getWeatherJSON];

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
    return [self.locationArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellView *cell = (CellView *)[tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
    
    Location *loc = [[Location alloc]init];
    
    cell.cityLabel.font = [UIFont fontWithName:@"Menlo" size:12];
    cell.cityLabel.textColor = [UIColor blueColor];
    cell.cityLabel.text = self.cityEntered;
    
    cell.tempLabel.font = [UIFont fontWithName:@"Menlo" size:22];
    cell.tempLabel.text = loc.currently.temperature;
    
    cell.currWeatherLabel.font = [UIFont fontWithName:@"helvetica" size:17];
    cell.currWeatherLabel.text = loc.currently.summary;

    
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
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      
        UITextField *city = myAlert.textFields[0];
        
        Location *locObj = [[Location alloc] init];
        locObj.cityName = city.text;
        [locObj coordsForAddress];
        locObj.delegate = self;
        
        [self.locationArray addObject:locObj];
    
        
        NSLog(@"The city is %@", locObj.cityName);
    
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


@end

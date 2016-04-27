//
//  LotteryViewControllerTableViewController.m
//  JackpotRedo
//
//  Created by MBPinTheAir on 20/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "LotteryViewControllerTableViewController.h"

@interface LotteryViewControllerTableViewController ()

@property (nonatomic, strong) NSMutableArray *ticketListArray;

@end

@implementation LotteryViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Quick Pick!";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTicket:)];
    
    self.ticketListArray = [[NSMutableArray alloc] initWithCapacity:0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)addTicket:(id)sender
{
    LotteryTickets *newTicket = [[LotteryTickets alloc]initWithRandomNumber];
    
    [self.ticketListArray addObject:newTicket];
    // NSLog(@"%@", self.ticketListArray);
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ticketListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quickPickCell" forIndexPath:indexPath];
    
//    LotteryTickets *newLotteryTicket = self.ticketListArray[indexPath.row];
//    cell.textLabel.text = [newLotteryTicket.lotteryNumbers componentsJoinedByString:@","];
    
    LotteryTickets *newLotteryTicket = self.ticketListArray[indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    
    [formatter setFormatWidth:2];
    [formatter setPaddingCharacter:@"0"];
    
    NSMutableArray *tempNumbers = [NSMutableArray array];
    for (NSNumber *number in newLotteryTicket.lotteryNumbers)
    {
        NSString *numberString = [formatter stringFromNumber:number];
        [tempNumbers addObject:numberString];
    }
    cell.textLabel.text = [tempNumbers componentsJoinedByString:@", "];
    
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

@end

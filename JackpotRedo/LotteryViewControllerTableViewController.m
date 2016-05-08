//
//  LotteryViewControllerTableViewController.m
//  JackpotRedo
//
//  Created by MBPinTheAir on 20/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "LotteryViewControllerTableViewController.h"
#import "TicketCheckerViewController.h"
#import "CellView.h"
#import "LotteryTickets.h"

@interface LotteryViewControllerTableViewController ()<TicketCheckerViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *ticketListArray;


@end

@implementation LotteryViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Quick Pick!";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTicket:)];
    
    self.ticketListArray = [[NSMutableArray alloc] initWithCapacity:0];
   
   // [self loadTicket];
}



-(void)sendWinningNumbers:(NSArray *)myTicketNumberss{
    
   
    for (LotteryTickets *ticketToCheck in self.ticketListArray){
        int matchingNumbers = 0;
        for (NSNumber *newNumber in ticketToCheck.lotteryNumbersArray){
            for (NSNumber *winningNumber in myTicketNumberss){
                if ([newNumber isEqualToNumber:winningNumber]) {
                    matchingNumbers++;
                }  //end if
            }  //end winning nos
        }  //end ticket nos
        switch (matchingNumbers) {
            case 3: {
                
            ticketToCheck.winAmount = 1;
                ticketToCheck.isWinner = YES;
            }
                break;
            case 4: {
                ticketToCheck.winAmount = 5;
                ticketToCheck.isWinner = YES;
            }
                break;
            case 5: {
                
            ticketToCheck.winAmount = 20;
                ticketToCheck.isWinner = YES;
            }
                break;
            case 6:{
                
            ticketToCheck.winAmount = 100;
                ticketToCheck.isWinner = YES;
            }
                break;
                
            default: {
                ticketToCheck.winAmount = 0;
                ticketToCheck.isWinner = NO;
            }
                break;
        }
 
    }
    [self.tableView reloadData];
}
-(void)addTicket:(id)sender
{
    LotteryTickets *newTicket = [[LotteryTickets alloc]initWithRandomNumber];
    [self.ticketListArray addObject:newTicket];
    
    
    [self.tableView reloadData];
    [self saveTicket];
}

#pragma mark NSCoding

- (NSURL *)applicationDocumentDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)saveTicket{

 NSString *mypath = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"lotteryNumbersArray"];
    
   
    NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:self.ticketListArray];
    
    [theData writeToFile:mypath atomically:YES];
}

-(void)loadTicket{
    
    NSString *path = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"lotteryNumbersArray"];
    
    NSData *myData = [NSData dataWithContentsOfFile:path];
    self.ticketListArray = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    
    [self.tableView reloadData];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ticketListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellView *cell = (CellView *)[tableView dequeueReusableCellWithIdentifier:@"quickPickCell" forIndexPath:indexPath];
    
//    LotteryTickets *newLotteryTicket = self.ticketListArray[indexPath.row];
//    cell.textLabel.text = [newLotteryTicket.lotteryNumbers componentsJoinedByString:@","];
    
    LotteryTickets *newLotteryTicket = self.ticketListArray[indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    
    [formatter setFormatWidth:2];
    [formatter setPaddingCharacter:@"0"];
    
    NSMutableArray *tempNumbers = [NSMutableArray array];
    for (NSNumber *number in newLotteryTicket.lotteryNumbersArray)
    {
        NSString *numberString = [formatter stringFromNumber:number];
        [tempNumbers addObject:numberString];
    }
    cell.ticketLabel.text = [tempNumbers componentsJoinedByString:@", "];
    
    if (newLotteryTicket.isWinner) {
        cell.annoucementLabel.text = @"You Win!";
        cell.annoucementLabel.textColor = [UIColor blueColor];

    }
    else if(newLotteryTicket.isWinner == NO){
        cell.annoucementLabel.text = @"Sorry Try again!";
        cell.annoucementLabel.textColor = [UIColor redColor];
    } else{
        cell.annoucementLabel.text = @"Checking ticket...";
    }
    
    cell.winAmountLabel.text = [NSString stringWithFormat:@"$ %lu",newLotteryTicket.winAmount];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TicketCheckerViewController  *tcVC = (TicketCheckerViewController *)[segue destinationViewController];
    tcVC.delegate = self;
    // Pass the selected object to the new view controller.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;


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



@end

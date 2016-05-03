//
//  CellViewController.h
//  JackpotRedo
//
//  Created by MBPinTheAir on 29/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewController : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *annoucementLabel;
@property (weak, nonatomic) IBOutlet UILabel *winAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;

@end

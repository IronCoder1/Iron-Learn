//
//  TicketCheckerViewController.h
//  JackpotRedo
//
//  Created by MBPinTheAir on 27/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TicketCheckerViewControllerDelegate<NSObject>

-(void)sendWinningNumbers:(NSArray *)myTicketNumberss;
@end


@interface TicketCheckerViewController : UIViewController
@property (nonatomic, weak) id <TicketCheckerViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *numbersToCheck;

@end

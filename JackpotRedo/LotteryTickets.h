//
//  LotteryTickets.h
//  JackpotRedo
//
//  Created by MBPinTheAir on 20/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryTickets : NSObject

@property (strong, nonatomic, readonly)  NSArray *lotteryNumbers;

-(instancetype) initWithRandomNumber;

@end

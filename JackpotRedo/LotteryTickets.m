//
//  LotteryTickets.m
//  JackpotRedo
//
//  Created by MBPinTheAir on 20/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "LotteryTickets.h"

@implementation LotteryTickets

-(instancetype)initWithRandomNumber
{
    if (self = [super init]) {
        
        NSMutableArray *holdingArray = [NSMutableArray array];
        //[[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 6 ; i++) {
            long randomNum = arc4random_uniform(53);
            NSLog(@"random num is %lu", randomNum);
            [holdingArray addObject:[NSNumber numberWithLong:randomNum]];
            
            NSLog(@"holdingarray  is %@", holdingArray);
        }
        _lotteryNumbers = holdingArray;
        // NSLog(@"%@", _lotteryNumbers);
    }
    return self;
}
@end

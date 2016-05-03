//
//  LotteryTickets.m
//  JackpotRedo
//
//  Created by MBPinTheAir on 20/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "LotteryTickets.h"
#import "LotteryViewControllerTableViewController.h"
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
        _lotteryNumbersArray = holdingArray;
      
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.lotteryNumbersArray forKey:@"lotteryNumbersArray"];
    [encoder encodeInteger:self.winAmount forKey:@"winAmount"];
    [encoder encodeBool:self.isWinner forKey:@"isWinner"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _lotteryNumbersArray = [decoder decodeObjectForKey:@"lotteryNumbersArray"];
        _winAmount = [decoder decodeIntegerForKey:@"winAmount"];
        _isWinner = [decoder decodeBoolForKey:@"isWinner"];
        
    }
    return self;
}

@end

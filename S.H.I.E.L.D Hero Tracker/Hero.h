//
//  Hero.h
//  S.H.I.E.L.D Hero Tracker
//
//  Created by MBPinTheAir on 24/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *homeworld;
@property (strong, nonatomic) NSString *powers;

-(instancetype)initWith:(NSMutableDictionary *)heroesDict;
@end

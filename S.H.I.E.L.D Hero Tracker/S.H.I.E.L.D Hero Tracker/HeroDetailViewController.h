//
//  HeroDetailViewController.h
//  S.H.I.E.L.D Hero Tracker
//
//  Created by MBPinTheAir on 24/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hero;  ///notifying of a hero class
@interface HeroDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeWorldLabel;
@property (weak, nonatomic) IBOutlet UILabel *powersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (strong, nonatomic) Hero *holdingHero;

@end

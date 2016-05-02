//
//  HeroDetailViewController.m
//  S.H.I.E.L.D Hero Tracker
//
//  Created by MBPinTheAir on 24/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//
#import "Hero.h"
#import "HeroDetailViewController.h"


@interface HeroDetailViewController ()

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // assign ui object instances to properties.
    self.nameLabel.text = self.holdingHero.name;
    self.homeWorldLabel.text = self.holdingHero.homeworld;
    self.powersLabel.text = self.holdingHero.powers;
    UIImage *heroDisplayImage = [UIImage imageNamed:self.holdingHero.myHeroImageName];
    self.heroImageView.image = heroDisplayImage;
    NSLog(@" heroesimage %@", heroDisplayImage);
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 

*/

@end

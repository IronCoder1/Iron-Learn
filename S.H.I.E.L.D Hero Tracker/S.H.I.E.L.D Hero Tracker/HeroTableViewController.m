//
//  HeroTableViewController.m
//  S.H.I.E.L.D Hero Tracker
//
//  Created by MBPinTheAir on 24/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "HeroTableViewController.h"
#import "Hero.h"
#import "HeroDetailViewController.h"

@interface HeroTableViewController ()
@property (strong, nonatomic) NSArray *heroList;
@property (strong, nonatomic) NSMutableArray *heroes;

//- (void)loadHeroes;  no need to predefine private methods

@end

@implementation HeroTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"S.H.I.E.L.D. Hero Tracker";
    [self loadHeroes];

}

//method to extract data from json and make it a local object
-(void)loadHeroes{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"heroes" ofType:@"json"];
    NSArray *heroList = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    
  //  NSMutableArray *heroes = [NSMutableArray array];
    //for every dictionairy in herolist array
    
    for (NSMutableDictionary *dict in heroList) {
        
//1.loop through 2.create a new Hero object 3.assign properties of object to keys in dictionary 4. add the newHero object to heroes array.
        Hero *newHero = [[Hero alloc]init];
        newHero.name = dict[@"name"];
        newHero.homeworld = dict[@"homeworld"];
        newHero.powers = dict[@"powers"];
        newHero.myHeroImageName = dict[@"image"];
// newHero.powers = [dict objectForKey:@"name"]; alternative way to extract and add to array
        [self.heroes addObject:newHero];
        
    }
//sort heroes array using sortdescriptor object
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [self.heroes sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
     NSLog(@" heroes obj from json %@", self.heroes);
    [self.tableView reloadData];
}

// for loop to go through array and create new hero object
//    for (int i = 0 ; i < [heroList count]; i++) { same purpose as for x in y
//
//        NSMutableDictionary *dict = [[[[heroList objectAtIndex:i]objectForKey:@"name"]objectForKey:@"homeworld"]objectForKey:@"powers"];
//
//        Hero *myHero = [[Hero alloc]initWith:heroesDict];
//
//        [heroes addObject:myHero];
//
//    }

// #pragma accessors
//getter method to initialise heroes array in place of alloc init
-(NSMutableArray *)heroes{
    if (_heroes == nil) {
        _heroes = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _heroes;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.heroes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
 //an instance of hero should be 1.placed at indexpat.row, 2. celltext should be a property of the object hero 3. the right detail label should be another property of the object.
    Hero *instanceHero = self.heroes[indexPath.row];
    cell.textLabel.text = instanceHero.name;
    cell.detailTextLabel.text = instanceHero.homeworld;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //call performseguemethod on herotableview instance and the sender is nil
    [self performSegueWithIdentifier:@"toDetailSegue" sender:nil];
    
    }

#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //check if the value of segue object is equal to "todetailsegue"
    if ([segue.identifier isEqualToString:@"toDetailSegue"]) {
// the instance of hvc will confirm to delegate
        HeroDetailViewController *hvc = (HeroDetailViewController *)[segue destinationViewController];
        
        //create a newpathfor selectedrow on tableview
        NSIndexPath *newPath = [self.tableView indexPathForSelectedRow];
        //fill the new path with an instane of Hero object sored in the array created earlier
        Hero *anotherHero = self.heroes[newPath.row];
        
        //check in the hvc for a property called holdinghero(pre declared in hdvc so import header) and assign this local instance of hero to hvc object with property holdinghero (example of inheritance)
        hvc.holdingHero = anotherHero;
    }
    
}



@end

//
//  TicketCheckerViewController.m
//  JackpotRedo
//
//  Created by MBPinTheAir on 27/04/2016.
//  Copyright © 2016 moorsideinc. All rights reserved.
//

#import "TicketCheckerViewController.h"

@interface TicketCheckerViewController () <UITextFieldDelegate>

@end

@implementation TicketCheckerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @" Ticket Checker";
    
    UITextField *myTextfield = [[UITextField alloc]init ];
    [myTextfield resignFirstResponder];
   
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

- (IBAction)checkResultButton:(id)sender {
    BOOL isValid = YES;
    NSMutableArray *myTicketNumbers = [NSMutableArray array];
    for (UITextField *myTextField in self.numbersToCheck) {
        if (([myTextField.text floatValue]) <1 || ([myTextField.text floatValue]) > 53) {
            myTextField.textColor = [UIColor redColor];
            isValid = NO;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Numbers must be of format \"00\" and in the range \"01 to 53\"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Re-enter Numbers" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else{
            myTextField.textColor = [UIColor blackColor];
        }
        int number = [myTextField.text intValue];
        [myTicketNumbers addObject:[NSNumber numberWithInt:number]];
      
    }
    if (isValid) {
        
    [self.delegate sendWinningNumbers:myTicketNumbers];
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"%@", myTicketNumbers);
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//
//}
/*
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
 
 

 @property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *numbersToCheck;
 
 [self.checkerTextField1];
 }else{
 NSMutableArray *ticketToCheck = [NSMutableArray arrayWithObjects:self.checkerTextField1.text, self.checkerTextField2.text, self.checkerTextField3.text, self.checkerTextField4.text, self.checkerTextField5.text, self.checkerTextField6.text, nil];
 
 NSLog(@"%@", ticketToCheck);
 
 
 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTicket:)];
 - (void)textFieldDidBeginEditing:(UITextField *)textField
 {
 NSLog(@"The did begin edit method was called");
 [self animateTextField: textField up: YES];
 }
 
 if (([self.checkerTextField1.text floatValue] || [self.checkerTextField2.text floatValue] ||[self.checkerTextField3.text floatValue] || [self.checkerTextField4.text floatValue] || [self.checkerTextField5.text floatValue] || [self.checkerTextField6.text floatValue]) > (float)53)
 
 - (void)textFieldDidEndEditing:(UITextField *)textField
 {
 [self animateTextField: textField up: NO];
 }




-(instancetype)addResultToArray:(NSString *)tf1 withTf2:(NSString *)tf2 withTf3:(NSString *)tf3 withTf4:(NSString *)tf4 withTf5:(NSString *)tf5 andTf6:(NSString *)tf6{
 
    return self;
    
}

*/


@end
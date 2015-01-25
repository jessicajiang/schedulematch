//
//  SignUpViewController.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "SignUpViewController.h"
#import "InitialViewController.h"
#import "AppCommunication.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *newusername;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;

@end

@implementation SignUpViewController
- (IBAction)createAccount:(id)sender {
    [self signUp];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) signUp {
    NSMutableDictionary *input = [NSMutableDictionary dictionary];
    NSString *latter = @"/signup";
    [input setValue:self.newusername.text forKey:@"username"];
    [input setValue:self.newpassword.text  forKey:@"password"];
    
    //putting the lines of code that we want to call inside of the block
    //what do you want the app to do when the network request is done
    /** when you finish uploading note to server, what do you want it to do */
    //latter withDictionary:
    
    [[AppCommunication sharedCommunicator] postRequest:latter withDictionary:input withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if([[fetchedData objectForKey:@"successful" ] isEqualToString:@"no"]){
                NSLog(@"%@ and %@", self.newusername.text, self.newpassword.text);
                NSLog(@"%@",[fetchedData objectForKey:@"info"]);
            }
            else {
                NSLog(@"Successful Signup");
                [self performSegueWithIdentifier:@"signUpSuccessful" sender:self];
            }
        });
    }];
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

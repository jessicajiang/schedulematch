//
//  InitialViewController.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "InitialViewController.h"
#import "AppCommunication.h"
#import "SignUpViewController.h"

@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation InitialViewController

- (IBAction)loginPressed:(id)sender {
    [self login];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) login {
    NSMutableDictionary *input = [NSMutableDictionary dictionary];
    NSString *latter = @"/login";
    [input setValue:self.username.text forKey:@"username"];
    [input setValue:self.password.text  forKey:@"password"];
    
    //putting the lines of code that we want to call inside of the block
    //what do you want the app to do when the network request is done
    /** when you finish uploading note to server, what do you want it to do */
    //[[AppCommunication sharedCommunicator] postRequestWithLatter:latter withDictionary: input withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        //dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"Login Complete! :3");
        //});
    //}];

    [[AppCommunication sharedCommunicator] postRequest:latter withDictionary:input withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{

            NSDictionary *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if([[fetchedData objectForKey:@"successful" ] isEqualToString:@"no"]){
                NSLog(@"%@ and %@", self.username.text, self.password.text);
                NSLog(@"%@",[fetchedData objectForKey:@"info"]);
            }
            else {
                NSLog(@"Successful Signup");
                NSLog(@"%@",[fetchedData objectForKey:@"info"]);
                [self performSegueWithIdentifier:@"loginSuccessful" sender:self];
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

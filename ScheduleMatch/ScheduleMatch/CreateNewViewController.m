//
//  CreateNewViewController.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/25/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "CreateNewViewController.h"
#import "Schedule.h"
#import "AppCommunication.h"

@interface CreateNewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UIDatePicker *starts;
@property (weak, nonatomic) IBOutlet UIDatePicker *ends;
@property (weak, nonatomic) NSString *startTimeString;
@property (weak, nonatomic) NSString *endTimeString;
//@property for repeat? maybe


@end

@implementation CreateNewViewController

- (IBAction)createPressed:(id)sender {
    [self postIt];
    
    Schedule *newSchedule = [[Schedule alloc]init];
    newSchedule.title = self.titleField.text;
    newSchedule.location = self.location.text;
    //TODO: ASK ABOUT DATE
    [self.TableScheduleList addObject:newSchedule];
    //[self performSegueWithIdentifier:@"goToTable" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) postIt {
    
    NSDate *startdate = [self.starts date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *startTimeString = [dateFormat stringFromDate:startdate];
    NSDate *enddate = [self.ends date];
    NSString *endTimeString = [dateFormat stringFromDate:enddate];
    
    
    NSString *latter = @"/schedule";
    
    NSMutableDictionary *input = [NSMutableDictionary dictionary];
    [input setValue:self.titleField.text forKey:@"title"];
    [input setValue:self.location.text  forKey:@"location"];
    [input setValue:self.startTimeString forKey:@"start"];
    [input setValue:self.endTimeString forKey:@"end"];

    
    [input setValue:[AppCommunication sharedCommunicator].username forKey:@"username"];
    
    
    /** when you finish uploading note to server, what do you want it to do */
    [[AppCommunication sharedCommunicator] postRequest:latter withDictionary:input withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Uploading Complete! :3");
            if([[input objectForKey:@"successful" ] isEqualToString:@"no"]){
                NSLog(@"%@",[input objectForKey:@"info"]);
            }
            else {
                NSLog(@"Successful Post");
                //[self performSegueWithIdentifier:@"backToDaily" sender:self];
                Schedule *newSchedule = [[Schedule alloc]init];
                
                newSchedule.title = [input objectForKey:@"title"];
                newSchedule.location = [input objectForKey:@"location"];
                newSchedule.endTimeString = [input objectForKey:@"end"];
                newSchedule.startTimeString = [input objectForKey:@"start"];
                [[AppCommunication sharedCommunicator].schedulelist addObject:newSchedule];
                
                [self performSegueWithIdentifier:@"Back" sender:self];
                
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

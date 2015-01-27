//
//  SearchControllerViewController.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "SearchControllerViewController.h"
#import "AppCommunication.h"
#import "Schedule.h"
#import "DailySchedule.h"

@interface SearchControllerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation SearchControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSLog (@"Search Pressed");
        [self getIt];

    return YES;
}
- (void) getIt
{
    [[AppCommunication sharedCommunicator] getRequestWithCompletion:[NSString stringWithFormat:@"/schedule/%@",[self searchField].text] withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Downloaded others!! :3");
            
            //converted response into HTTP response
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger responseStatusCode = [httpResponse statusCode];
            
            //if it works, then yay, if not then :(
            if(responseStatusCode == 200)
            {
                //converting the NSData *data ^^ up there to something we can use
                NSArray *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                for(int i = 0; i < fetchedData.count; i++)
                {
                    NSDictionary* scheduleDictionary = [fetchedData objectAtIndex:i];
                    
                    Schedule *newSchedule = [[Schedule alloc] init];
                    
                    newSchedule.title = [scheduleDictionary objectForKey:@"title"];
                    newSchedule.location = [scheduleDictionary objectForKey:@"location"];
                    newSchedule.endTimeString = [scheduleDictionary objectForKey:@"end"];
                    newSchedule.startTimeString = [scheduleDictionary objectForKey:@"start"];
                    
                    //add this to the array
                    [[AppCommunication sharedCommunicator].schedulelist addObject:newSchedule];
                    
                }
                //updating
                    [self performSegueWithIdentifier:@"searchResults" sender:self];
            }
            else
            {
                NSLog(@"error");
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

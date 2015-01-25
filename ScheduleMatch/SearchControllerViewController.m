//
//  SearchControllerViewController.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "SearchControllerViewController.h"

@interface SearchControllerViewController ()

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
    return YES;
    
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

//
//  TabViewController.m
//  ScheduleMatch
//
//  Created by sloot on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "TabViewController.h"
#import "AppCommunication.h"
#import "Schedule.h"
#import "DailySchedule.h"
@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedIndex:2];
    // Do any additional setup after loading the view.
    
    [AppCommunication sharedCommunicator].schedulelist= [NSMutableArray array];
    [(DailySchedule*)((UINavigationController*)self.viewControllers[2]).viewControllers[0] getIt];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

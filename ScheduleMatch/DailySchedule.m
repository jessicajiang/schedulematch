//
//  DailySchedule.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/25/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "DailySchedule.h"
#import "Schedule.h"
#import "CreateNewViewController.h"
#import "AppCommunication.h"

@interface DailySchedule()
{
    int selectedIndex;
}

@end

@implementation DailySchedule

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"appearing!!");
    self.tableView.reloadData;
    
}


/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [AppCommunication sharedCommunicator].schedulelist.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = ((Schedule*)[AppCommunication sharedCommunicator].schedulelist[indexPath.row]).title;
    //cell.textLabel.alpha = 0.2;
    //cell.textLabel.backgroundColor = [UIColor magentaColor];
    //clear color
    return cell;
}

- (IBAction)goBackToTable:(UIStoryboardSegue*)goBackSegue
{
    
}

- (void) scheduleView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"blah blah blah" sender:self];
    
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[AppCommunication sharedCommunicator].schedulelist removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } //else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)scheduleView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

//retrieves info from the interwebs and sets it up in the note
- (void) getIt
{
    [[AppCommunication sharedCommunicator] getRequestWithCompletion:[NSString stringWithFormat:@"/schedule/%@",[AppCommunication sharedCommunicator].username] withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Downloaded!! :3");
            
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
                    newSchedule.location = [scheduleDictionary objectForKey:@"idk yet"];
                    
                    //add this to the array
                    [[AppCommunication sharedCommunicator].schedulelist addObject:newSchedule];
                    
                }
                //updating
                
                [self.tableView reloadData];
            }
            else
            {
                NSLog(@"error");
            }
            
        });
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"NewNote"])
    {
        ((CreateNewViewController*)[segue destinationViewController]).TableScheduleList = [AppCommunication sharedCommunicator].schedulelist;
        NSLog(@"NewNote");
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
@end

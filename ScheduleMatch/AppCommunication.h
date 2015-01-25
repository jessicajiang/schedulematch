//
//  AppCommunication.h
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCommunication : NSObject

-(void)postRequest:(NSDictionary*) input withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion;
-(void)getRequestWithCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion;

@end

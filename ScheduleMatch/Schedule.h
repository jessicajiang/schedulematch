//
//  Schedule.h
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/25/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject

@property (nonatomic, strong) NSString* startTimeString;
@property (nonatomic, strong) NSString* endTimeString;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSDate* starts;
@property (nonatomic, strong) NSDate* ends;


@end

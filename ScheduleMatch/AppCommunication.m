//
//  AppCommunication.m
//  ScheduleMatch
//
//  Created by Jessica Jiang on 1/24/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

#import "AppCommunication.h"

@implementation AppCommunication
static NSString *const ROOTURL=@"http://perfwect.herokuapp.com";

+(instancetype)sharedCommunicator
{
    static AppCommunication *sharedCommunicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedCommunicator = [[AppCommunication alloc]init];
                  });
    return sharedCommunicator;
}


-(void)postRequest:(NSString *)latter withDictionary:(NSDictionary *)input withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion
{
    
    NSString *fixedURL = [NSString stringWithFormat:@"%@%@",ROOTURL,latter];
    
    NSURL *url = [NSURL URLWithString:fixedURL];
    
    //creating the session with standard settings?
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    //converting our dictionary to data
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:input options:kNilOptions error:&error];
    
    //anytime you have an input dictionary you have to use uploadTask
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler: completion];
    //start uploading with the request to the session, when it's done call the code inside of the completion
    [uploadTask resume];
    
}


-(void)getRequestWithCompletion:(NSString*)latter withCompletion: (void (^)(NSData *, NSURLResponse *, NSError *))completion
{
    
    NSString *fixedURL = [NSString stringWithFormat:@"%@%@",ROOTURL, latter];
    
    //makes url
    NSURL *url = [NSURL URLWithString:fixedURL];
    
    //creating the session with standard settings?
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // changed this
    request.HTTPMethod = @"GET";
    
    //changed from upload to get
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:completion];
    [sessionTask resume];
    

}


@end

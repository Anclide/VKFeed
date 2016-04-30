//
//  NetManager.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 13.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "NetManager.h"
#import "FeedMapper.h"
#import "AppDelegate.h"

@interface NetManager () <UIWebViewDelegate>

@end

@implementation NetManager 

+ (NetManager *)sharedManager {
    static NetManager *_sharedNetManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetManager = [[self alloc] initWithBaseURL:nil];
        AFJSONResponseSerializer *responeSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [_sharedNetManager setResponseSerializer:responeSerializer];
    });
    return _sharedNetManager;
}

- (void)logout:(UIViewController *)sender {
    NSString *url = @"https://oauth.vk.com/logout";
    
    NSDictionary *params = @{
                             @"access_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]
                             };
    
    [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"logout complete");
        [sender.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
   
}

- (void)loadPostsFromBeggining:(BOOL)from {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    NSString *url = @"https://api.vk.com/method/newsfeed.get";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSNumber *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"end_date"];

    [params setObject:token forKey:@"access_token"];
    [params setObject:@"post" forKey:@"filter"];
    if (from) {
        [params setObject:@"100" forKey:@"count"];
        if (date) {
            [params setObject:date forKey:@"end_date"];
        }
    } else {
        [params setObject:@"10" forKey:@"count"];
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"start_from"]  forKey:@"start_from"];
        
    }
    
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"response class:%@", [responseObject class]);
//            NSLog(@"inner response class:%@", [[responseObject objectForKey:@"response"] class]);
//            NSLog(@"groups response class:%@", [[responseObject[@"response"] objectForKey:@"groups"] class]);
//            NSLog(@"new_offset response class:%@", [[responseObject[@"response"] objectForKey:@"new_offset"] class]);
//            NSLog(@"resposne count: %lu", [[responseObject[@"response"] objectForKey:@"Items"] count]);
            if ([[responseObject[@"response"] objectForKey:@"Items"] count] > 20) {
                AppDelegate *ap = [[UIApplication sharedApplication] delegate];
                [ap deleteAll];
            }
            NSLog(@"%@", responseObject);
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject[@"response"] objectForKey:@"new_offset"]  forKey:@"new_offset"];
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject[@"response"] objectForKey:@"new_from"] forKey:@"start_from"];
            [[NSUserDefaults standardUserDefaults] setObject:[[[responseObject[@"response"] objectForKey:@"Items"] objectAtIndex:0] objectForKey:@"date"]   forKey:@"end_date"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [FeedMapper saveData:responseObject[@"response"]];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
}

@end

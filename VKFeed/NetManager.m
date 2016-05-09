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
#import "FetchedResultController.h"

static BOOL isFirst = YES;

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
    AppDelegate *ap = [[UIApplication sharedApplication] delegate];
    [ap deleteAll];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"You successfully logged out" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender dismissViewControllerAnimated:YES completion:nil];
    }]];
    [sender presentViewController:alert animated:YES completion:nil];

   
}

- (void)loadPostsFromBeggining:(BOOL)from withCompletion:(void(^)(NSArray *, NSError *))completion{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    NSString *url = @"https://api.vk.com/method/newsfeed.get";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSNumber *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"end_date"];
    
    NSString *startFrom = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"start_from"]];
    
    

    [params setObject:token forKey:@"access_token"];
    [params setObject:@"post" forKey:@"filter"];
    [params setObject:@"5.52" forKey:@"v"];
    if (from) {
        if (date) {
            [params setObject:date forKey:@"end_time"];
        } else {
             [params setObject:@"10" forKey:@"count"];
        }
    } else if (startFrom.length > 5){
        //NSLog(@"start_from: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"start_from"]);
        [params setObject:startFrom  forKey:@"start_from"];
        
    }
    
    [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"loaded: %@", responseObject[@"response"]);
        if (!from || isFirst) {
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject[@"response"] objectForKey:@"next_from"] forKey:@"start_from"];
            isFirst = NO;
        }
        [[NSUserDefaults standardUserDefaults] setObject:[[[responseObject[@"response"] objectForKey:@"Items"] objectAtIndex:0] objectForKey:@"date"]   forKey:@"end_date"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [FeedMapper saveData:responseObject[@"response"]];
        NSArray *array = [FetchedResultController getPosts];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(array, nil);
        });
        //NSLog(@"start_from: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"start_from"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
}

@end

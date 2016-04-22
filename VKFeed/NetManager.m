//
//  NetManager.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 13.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "NetManager.h"

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
   
}

- (void)loadPosts {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *url = [NSString stringWithFormat:@"https://api.vk.com/method/newsfeed.get?access_token=%@&count=10", token];
    
    NSString *testUrl = @"https://api.vk.com/method/newsfeed.get";
    
    NSDictionary *params = @{
                             @"access_token":token,
                             @"count":@"10"
                             };
    
        [self GET:testUrl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            if ([responseObject[@"response"] isKindOfClass:[NSArray class]]) {
                NSArray *array = responseObject[@"response"];
                NSLog(@"%@", array);
                NSLog(@"%@", task.currentRequest.URL);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
}

@end

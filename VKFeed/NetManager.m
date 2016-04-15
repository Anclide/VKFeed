//
//  NetManager.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 13.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "NetManager.h"


static NSString *accessToken;

@interface NetManager () <UIWebViewDelegate>

@end

@implementation NetManager 

+ (NetManager *)sharedManager {
    static NetManager *_sharedNetManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetManager = [[self alloc] initWithBaseURL:nil];
    });
    return _sharedNetManager;
}

@end

//
//  NetManager.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 13.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetManager : AFHTTPSessionManager

+ (NetManager *)sharedManager;


@end

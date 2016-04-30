//
//  Profile.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 22.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileModel : NSObject

@property (nonatomic ,strong) NSString *userId;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *photoUrl;

@end

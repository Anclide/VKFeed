//
//  ProfileMapper.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 23.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "ProfileMapper.h"
#import "ProfileModel.h"

@implementation ProfileMapper

+ (ProfileModel *)profileWithDictionary:(NSDictionary *)dict {
    ProfileModel *profile = [ProfileModel new];
    profile.userId = dict[@"uid"];
    profile.firstName = dict[@"first_name"];
    profile.lastName = dict[@"last_name"];
    profile.photoUrl = dict[@"photo_medium_rec"];
    
    return profile;
}

@end

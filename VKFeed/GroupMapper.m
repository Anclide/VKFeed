//
//  GroupMapper.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 23.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "GroupMapper.h"
#import "GroupModel.h"

@implementation GroupMapper

+ (GroupModel *)groupWithDictionary:(NSDictionary *)dict {
    GroupModel *group = [GroupModel new];
    group.gid = dict[@"gid"];
    group.photoUrl = dict[@"photo_medium"];
    group.name = dict[@"name"];
    
    return  group;
}


@end

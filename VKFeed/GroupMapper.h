//
//  GroupMapper.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 23.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GroupModel;

@interface GroupMapper : NSObject

+ (GroupModel *)groupWithDictionary:(NSDictionary *)dict;

@end

//
//  ItemMapper.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 23.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "ItemMapper.h"
#import "ItemModel.h"

@implementation ItemMapper

+ (ItemModel *)itemWithDictionary:(NSDictionary *)dict {
    ItemModel *item = [ItemModel new];
    item.postId = dict[@"post_id"];
    item.date = dict[@"date"];
    item.likes = dict[@"likes"];
    item.reposts = dict[@"reposts"];
    item.sourceId = dict[@"source_id"];
    item.text = dict[@"text"];
    item.attachments = dict[@"attachments"];
    
    return item;
}

@end

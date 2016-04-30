//
//  Item.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 22.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject
//author identificator
@property (nonatomic, strong) NSString *sourceId;

//post date from unixtime
@property (nonatomic, strong) NSDate *date;

//post identificator
@property (nonatomic, strong) NSNumber *postId;

//post text
@property (nonatomic, strong) NSString *text;

//information about likes in this post
@property (nonatomic, strong) NSDictionary *likes;

//information about reposts in this post
@property (nonatomic, strong) NSDictionary *reposts;

//attach files in post
@property (nonatomic, strong) NSArray *attachments;


@end

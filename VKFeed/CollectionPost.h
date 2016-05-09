//
//  CollectionPost.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 04.05.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionPost : NSObject

@property (strong, nonatomic) NSNumber *postId;

@property (strong, nonatomic) NSString *authorName;

@property (strong, nonatomic) NSString *authorImageUrl;

@property (strong, nonatomic) NSDate *postDate;

@property (strong, nonatomic) NSArray *photos;

@property (strong, nonatomic) NSString *text;

@end

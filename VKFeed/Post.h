//
//  Post.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 27.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString *authorName;

@property (nonatomic, strong) NSString *authorImageUrl;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *itemImageUrl;

@property (nonatomic, strong) NSNumber *imageHeight;

@property (nonatomic, strong) NSNumber *imageWidth;

@property (nonatomic, strong) NSNumber *likes;

@property (nonatomic, strong) NSNumber *reposts;

@property (nonatomic, strong) NSString *bigItemImageUrl;

@end

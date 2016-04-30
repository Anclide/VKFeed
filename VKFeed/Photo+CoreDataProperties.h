//
//  Photo+CoreDataProperties.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 29.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *postId;
@property (nullable, nonatomic, retain) NSString *src;
@property (nullable, nonatomic, retain) NSString *src_big;
@property (nullable, nonatomic, retain) NSString *src_small;
@property (nullable, nonatomic, retain) NSNumber *width;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) Item *item;

@end

NS_ASSUME_NONNULL_END

//
//  Item+CoreDataProperties.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 27.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *postId;
@property (nullable, nonatomic, retain) NSNumber *sourceId;
@property (nullable, nonatomic, retain) NSNumber *date;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSNumber *likes;
@property (nullable, nonatomic, retain) NSNumber *reposts;
@property (nullable, nonatomic, retain) NSSet<Photo *> *item;

@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addItemObject:(Photo *)value;
- (void)removeItemObject:(Photo *)value;
- (void)addItem:(NSSet<Photo *> *)values;
- (void)removeItem:(NSSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END

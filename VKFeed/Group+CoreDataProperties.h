//
//  Group+CoreDataProperties.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 27.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Group.h"

NS_ASSUME_NONNULL_BEGIN

@interface Group (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *gid;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *photoUrl;

@end

NS_ASSUME_NONNULL_END

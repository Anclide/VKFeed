//
//  Profile+CoreDataProperties.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 27.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Profile.h"

NS_ASSUME_NONNULL_BEGIN

@interface Profile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END

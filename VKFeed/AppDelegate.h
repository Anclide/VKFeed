//
//  AppDelegate.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 13.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//@property (strong, nonatomic)
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)deleteAll;


@end


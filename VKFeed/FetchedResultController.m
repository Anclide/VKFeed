//
//  FetchedResultController.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 26.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "FetchedResultController.h"
#import "AppDelegate.h"
#import "Item.h"
#import "Post.h"
#import "Photo.h"
#import "Group.h"
#import "Profile.h"

@implementation FetchedResultController

+ (NSArray *)getPosts {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSSortDescriptor *itemSorter = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:@[itemSorter]];
    NSError *error = nil;
    NSArray *reqestResult = [[moc executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (reqestResult) {
        NSLog(@"count: %lu", (unsigned long)reqestResult.count);
        for (Item *item in reqestResult) {
            //NSLog(@"item: %@", item);
            Post *post = [[Post alloc] init];
            post.text = item.text;
            post.likes = item.likes;
            post.reposts = item.reposts;
            for (Photo *photo in item.item.allObjects) {
                //NSLog(@"photo: %@", photo);
                post.itemImageUrl = photo.src;
                post.bigItemImageUrl = photo.src_big;
                post.imageWidth = photo.width;
                post.imageHeight = photo.height;
            }
            NSLog(@"source: %@ and class: %@", item.sourceId, [item.sourceId class]);
            if ([item.sourceId integerValue] < 0) {
                NSString *str = [item.sourceId stringValue];
                str = [str substringFromIndex:1];
                //NSLog(@"%@", str);
                NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Group"];
                [request setReturnsObjectsAsFaults:NO];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gid = %@", str];
                [request setPredicate:predicate];
                Group *group = [[[moc executeFetchRequest:request error:&error] mutableCopy] objectAtIndex:0];
                post.authorName = group.name;
                post.authorImageUrl = group.photoUrl;
            } else {
                NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId = %@", item.sourceId];
                [request setPredicate:predicate];
                [request setReturnsObjectsAsFaults:NO];
                Profile *profile = [[[moc executeFetchRequest:request error:&error] mutableCopy] objectAtIndex:0];
                post.authorName = [NSString stringWithFormat:@"%@ %@", profile.firstName, profile.lastName];
                post.authorImageUrl = profile.imageUrl;
            }
            [array addObject:post];
            
        }
    } else {
        NSLog(@"no data");
    }
    return [array mutableCopy];
}

@end

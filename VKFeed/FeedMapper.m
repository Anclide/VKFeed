//
//  FeedMapper.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 22.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "FeedMapper.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Group.h"
#import "Item.h"
#import "Photo.h"
#import "Profile.h"

@implementation FeedMapper

+ (void)saveData:(id)respone {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [app managedObjectContext];
    NSError *error = nil;
    for (NSDictionary *dict in [respone objectForKey:@"groups"]) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Group"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gid = %@", dict[@"id"]];
        [fetchRequest setPredicate:predicate];
        NSUInteger count = [moc countForFetchRequest:fetchRequest error:&error];
        if (count == 0) {
            Group *group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:moc];
            [group setGid:dict[@"id"]];
            [group setName:dict[@"name"]];
            if (dict[@"photo_100"] == 0) {
                [group setPhotoUrl:dict[@"photo_50"]];
            } else {
                [group setPhotoUrl:dict[@"photo_100"]];
            }
            if (![moc save:&error])
            {
                NSLog(@"Save did not complete successfully. Error: %@",
                      [error localizedDescription]);
            }
        }
    }
    
    for (NSDictionary *dict in [respone objectForKey:@"items"]) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
        NSPredicate *precate = [NSPredicate predicateWithFormat:@"postId = %@", dict[@"post_id"]];
        [fetchRequest setPredicate:precate];
        NSUInteger count = [moc countForFetchRequest:fetchRequest error:&error];
        if (count == 0) {
            Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc];
            [item setPostId:dict[@"post_id"]];
            [item setDate:dict[@"date"]];
            [item setText:dict[@"text"]];
            [item setLikes:dict[@"likes"][@"count"]];
            [item setReposts:dict[@"reposts"][@"count"]];
            [item setSourceId:dict[@"source_id"]];
                if (dict[@"attachments"]) {
                    for (NSDictionary *attachment in dict[@"attachments"]) {
                        if ([attachment[@"type"] isEqualToString:@"photo"]) {
                            NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
                            NSPredicate *imagePredicate = [NSPredicate predicateWithFormat:@"src = %@", attachment[@"photo"][@"photo_130"]];
                            [req setPredicate:imagePredicate];
                            NSUInteger imageCount = [moc countForFetchRequest:req error:&error];
                            if (imageCount == 0) {
                                Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                                                             inManagedObjectContext:moc];
                                [photo setPostId:dict[@"post_id"]];
                                [photo setSrc:attachment[@"photo"][@"photo_130"]];
                                [photo setSrc_big:attachment[@"photo"][@"photo_604"]];
                                [photo setSrc_small:attachment[@"photo"][@"photo_75"]];
                                [photo setWidth:attachment[@"photo"][@"width"]];
                                [photo setHeight:attachment[@"photo"][@"height"]];
                                [item addItemObject:photo];
                            }
                        }
                    }
                }
            if (![moc save:&error])
            {
                NSLog(@"Save did not complete successfully. Error: %@",
                      [error localizedDescription]);
            }
            if (![moc save:&error])
            {
                NSLog(@"Save did not complete successfully. Error: %@",
                      [error localizedDescription]);
            }
        }
        
    }
    if (respone[@"profiles"]) {
        for (NSDictionary *dict in respone[@"profiles"]) {
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId = %@", dict[@"id"]];
            [request setPredicate:predicate];
            NSUInteger count = [moc countForFetchRequest:request error:&error];
            if (count == 0) {
                Profile *profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile"
                                                                 inManagedObjectContext:moc];
                [profile setUserId:dict[@"id"]];
                [profile setFirstName:dict[@"first_name"]];
                [profile setLastName:dict[@"last_name"]];
                [profile setImageUrl:dict[@"photo_100"]];
                
                if (![moc save:&error])
                {
                    NSLog(@"Save did not complete successfully. Error: %@",
                          [error localizedDescription]);
                }
            }
            
        }
    }
    
}

@end

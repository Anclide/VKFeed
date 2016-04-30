//
//  Group.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 22.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

//group identificator
@property (nonatomic, strong) NSString *gid;

//group name
@property (nonatomic, strong) NSString *name;

//group avatar url
@property (nonatomic, strong) NSString *photoUrl;

@end

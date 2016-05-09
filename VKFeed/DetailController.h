//
//  DetailController.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 30.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionPost;

@interface DetailController : UICollectionViewController

@property (nonatomic, strong) CollectionPost *post;

@end

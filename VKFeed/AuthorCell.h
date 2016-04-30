//
//  AuthorCell.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 27.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *authorImage;

@property (nonatomic, weak) IBOutlet UILabel *authorName;

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *name;

@end

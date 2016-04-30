//
//  CustomCell.h
//  VKFeed
//
//  Created by Victor Bogatyrev on 29.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *text;

@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end

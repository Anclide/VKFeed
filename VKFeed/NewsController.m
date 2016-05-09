//
//  NewsController.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 21.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "NewsController.h"
#import "NetManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "FetchedResultController.h"
#import "Post.h"
#import "AuthorCell.h"
#import "OtherCell.h"
#import "CustomCell.h"
#import "ImageCell.h"
#import "TextCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailController.h"
#import "CollectionPost.h"


static BOOL needToScrool = YES;


@interface NewsController ()
{
    NSArray *posts;
}
@property (strong, nonatomic) CollectionPost *detailPost;

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [refreshControl.superview sendSubviewToBack:refreshControl];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    //[self refresh:refreshControl];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AuthorCell" bundle:nil] forCellReuseIdentifier:@"author_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"custom_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherCell" bundle:nil] forCellReuseIdentifier:@"other_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"image_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextCell" bundle:nil] forCellReuseIdentifier:@"text_cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"posts after loading: %lu", (unsigned long)posts.count);
}

- (void)refresh:(UIRefreshControl *)refrshControl {
    [self reloadData];
    [refrshControl endRefreshing];
}

- (void)reloadData {
    [[NetManager sharedManager] loadPostsFromBeggining:YES withCompletion:^(NSArray *array, NSError *error) {
        posts = array;
        if (posts.count == 0) {
            posts = [FetchedResultController getPosts];
        }
        [self.tableView reloadData];
    }];
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = posts[indexPath.section];
    if (post.itemImageUrl != nil) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)hasTextAtIndexPath:(NSIndexPath *)indexPath {
     Post *post = posts[indexPath.section];
    if (post.text == nil || [post.text isEqualToString:@""]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)changeDateFormat:(NSDate *)date {
    NSString *formattedDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"RU"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    formattedDate = [dateFormatter stringFromDate:date];
    
    return formattedDate;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return posts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)calculateHeightForCustomCell:(UITableViewCell *)tableViewCell {
    [tableViewCell layoutIfNeeded];
    
    CGSize size = [tableViewCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (TextCell *)textCellAtIndexPath:(NSIndexPath *)indexPath {
    TextCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"text_cell"];
    Post *post = posts[indexPath.section];
    cell.text.text = [self htmlTextToPlain:post.text];
    
    return cell;
}

- (ImageCell *)imageCellAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"image_cell"];
    Post *post = posts[indexPath.section];
    cell.customImageView.contentMode = UIViewContentModeCenter;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"image_image: %@", post.bigItemImageUrl);
        [cell.customImageView sd_setImageWithURL:[NSURL URLWithString:post.bigItemImageUrl] placeholderImage:nil];
    });

    NSLayoutConstraint *aspectRatio = [NSLayoutConstraint constraintWithItem:cell.customImageView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:cell.customImageView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:[post.imageHeight floatValue]/[post.imageWidth floatValue]
                                                                    constant:0];
    aspectRatio.priority = 1000;
    [cell.customImageView addConstraint:aspectRatio];
    [cell layoutIfNeeded];
    [cell layoutSubviews];
    return cell;
}

- (CustomCell *)customCellAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"custom_cell"];
    Post *post = posts[indexPath.section];
    cell.text.text = [self htmlTextToPlain:post.text];
    NSLog(@"custom_image: %@", post.bigItemImageUrl);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell.customImageView sd_setImageWithURL:[NSURL URLWithString:post.bigItemImageUrl] placeholderImage:nil];
    });
    NSLayoutConstraint *aspectRatio = [NSLayoutConstraint constraintWithItem:cell.customImageView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:cell.customImageView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:[post.imageHeight floatValue]/[post.imageWidth floatValue]
                                                                    constant:0];
    aspectRatio.priority = 1000;
    [cell.customImageView addConstraint:aspectRatio];
    [cell layoutIfNeeded];
    [cell layoutSubviews];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSString *)htmlTextToPlain:(NSString *)html {
    NSAttributedString *string = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    if (string.length > 200) {
        NSString *result = [NSString stringWithFormat:@"%@...", [[string string] substringToIndex:200]];
        return result;
    }
    return [string string];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = posts[indexPath.section];
    _detailPost = [[CollectionPost alloc] init];
    _detailPost.postId = post.postId;
    _detailPost.photos = [FetchedResultController getPostPhotosWithPostId:post.postId];
    _detailPost.postDate = post.date;
    _detailPost.authorName = post.authorName;
    _detailPost.authorImageUrl = post.authorImageUrl;
    _detailPost.text = post.text;
    
    [self performSegueWithIdentifier:@"detail_segue" sender:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Post *post = [posts objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        AuthorCell *authorCell = [tableView dequeueReusableCellWithIdentifier:@"author_cell" forIndexPath:indexPath];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [authorCell.authorImage sd_setImageWithURL:[NSURL URLWithString:post.authorImageUrl] placeholderImage:nil];
        });
        authorCell.authorName.text = post.authorName;
        authorCell.dateLabel.text = [self changeDateFormat:post.date];
        return authorCell;
    } else if (indexPath.row == 1) {
        if ([self hasTextAtIndexPath:indexPath] && [self hasImageAtIndexPath:indexPath]) {
            return [self customCellAtIndexPath:indexPath];
        } else if ([self hasImageAtIndexPath:indexPath] && ![self hasTextAtIndexPath:indexPath]){
            return [self imageCellAtIndexPath:indexPath];
        } else {
            return [self textCellAtIndexPath:indexPath];
        }
       
    } else {
        OtherCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"other_cell" forIndexPath:indexPath];
        otherCell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", [post.likes stringValue]];
        otherCell.repostsLabel.text = [NSString stringWithFormat:@"Reposts: %@", [post.reposts stringValue]];
        return otherCell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffset = scrollView.contentOffset.y;
    //NSLog(@"current_offset: %f", currentOffset);
    CGFloat maximumHeigth = scrollView.contentSize.height - scrollView.frame.size.height;
    //NSLog(@"maximumHeight: %f", maximumHeigth);
    if (currentOffset > 0 && currentOffset >= maximumHeigth) {
        if (needToScrool) {
            needToScrool = NO;
            [[NetManager sharedManager] loadPostsFromBeggining:NO withCompletion:^(NSArray *array, NSError *error) {
                posts = array;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.tableView reloadData];
                });
                needToScrool = YES;
            }];
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail_segue"]) {
        DetailController *detail = [segue destinationViewController];
        detail.post = _detailPost;
    }
    _detailPost = nil;
}


@end

//
//  DetailController.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 30.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "DetailController.h"
#import "FetchedResultController.h"
#import "CollectionPost.h"
#import "DetailCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Photo.h"
#import "HeaderView.h"


@interface DetailController ()

@end

@implementation DetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"collection loaded: %@", _post);
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _post.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"forIndexPath:indexPath];
    Photo *photo = _post.photos[indexPath.row];
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:photo.src_big]];
    NSLayoutConstraint *aspectRatio = [NSLayoutConstraint constraintWithItem:cell.image
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:cell.image
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:[photo.height floatValue]/[photo.width floatValue]
                                                                    constant:0];
    aspectRatio.priority = 1000;
    [cell.image addConstraint:aspectRatio];
    [cell layoutIfNeeded];
    [cell layoutSubviews];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Text" forIndexPath:indexPath];
        view.textLabel.text = _post.text;
        
        return view;
    } else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, collectionView.frame.size.width -16, CGFLOAT_MAX)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont fontWithName:@"HelvetivaNeue" size:17];
    label.text = _post.text;
    [label sizeToFit];
    return CGSizeMake(collectionView.frame.size.width, label.frame.size.height +16);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

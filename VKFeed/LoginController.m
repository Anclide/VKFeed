//
//  LoginController.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 13.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "LoginController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "NewsController.h"
#import "NetManager.h"

@interface LoginController ()

@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *feedButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)feedButtonTapped:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]) {
        [self performSegueWithIdentifier:@"feed_segue" sender:self];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please, log in with your VK account" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)logoutButtonTapped:(id)sender {
    [[NetManager sharedManager] logout:self];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"feed_segue"]) {
        NewsController *newsFeed = [segue destinationViewController];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

//
//  OAuthViewController.m
//  VKFeed
//
//  Created by Victor Bogatyrev on 21.04.16.
//  Copyright © 2016 Victor Bogatyrev. All rights reserved.
//

#import "OAuthViewController.h"
#import "NewsController.h"

@interface OAuthViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *loginView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=wall,offline,friends&response_type=token&v=5.50", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"APP_ID"]];
    NSURL *address = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:address];
    [_loginView loadRequest:request];
    //NSLog(@"%@", url);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //NSLog(@"%@", _loginView.request.URL.absoluteString);
    if ([_loginView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
        NSString *accessToken = _loginView.request.URL.absoluteString;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^https:\/\/oauth.vk.com\/blank.html#access_token=(.+?)&expires_in=[0-9]*&user_id=[0-9]*$"
                                                                               options:0
                                                                                 error:nil];
        NSTextCheckingResult *result = [regex firstMatchInString:accessToken
                                                         options:NSAnchoredSearch
                                                           range:NSMakeRange(0, accessToken.length)];
        NSRange tokenRange = [result rangeAtIndex:1];
        accessToken = [accessToken substringWithRange:tokenRange];
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"LOAD_NEWS" sender:self];
        NSLog(@"token: %@", accessToken);
    } else {
        
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error);
}


#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LOAD_NEWS"]) {
        NewsController *news = segue.destinationViewController;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

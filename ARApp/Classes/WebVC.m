//
//  WebVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 28/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "WebVC.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface WebVC () <UIWebViewDelegate>
@end
@implementation WebVC

-(void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (IBAction)dismiss:(id)sender {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
}

@end

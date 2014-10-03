//
//  ViewController.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 23/09/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "ViewController.h"
#import <CatchoomSDK/CatchoomSDK.h>
#import <CatchoomSDK/CatchoomCloudRecognitionItem.h>

@interface ViewController () <CatchoomCloudRecognitionProtocol, CatchoomSDKProtocol, UIAlertViewDelegate> {
    // Catchoom SDK reference
    CatchoomSDK *_sdk;
    CatchoomCloudRecognition *_cloudRecognition;
    __weak IBOutlet UIView *videoPreviewView;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // setup the Catchoom SDK
    _sdk = [CatchoomSDK sharedCatchoomSDK];
    [_sdk setDelegate:self];
    
    _cloudRecognition = [_sdk getCloudRecognitionInterface];
    [_cloudRecognition setDelegate:self];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    
    // Start Video Preview for search and tracking
    [_sdk startCaptureWithView: self->videoPreviewView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchPressed:(UIButton *)sender {
    [_cloudRecognition singleShotSearch];
    [self->videoPreviewView setHidden:YES];
    [self->activityIndicator startAnimating];
}

#pragma mark - CatchoomSDK Delegate

- (void) didStartCapture {
    // Get the CloudRecognition and set self as delegate to receive search responses
    [_cloudRecognition setToken:@"cbaf95971df4436c"];
}

#pragma mark - CatchoomCloudRecognition Delegate

- (void) didGetSearchResults:(NSArray *)resultItems {
    [self->activityIndicator stopAnimating];
    if ([resultItems count] == 1) {
        // Found one item !!!
        NSLog(@"Trobat!");
        //CatchoomCloudRecognitionItem *item = [resultItems objectAtIndex:0];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Trobat" message:@"Yuju!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Nothing found"];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}

-(void)didFailWithError:(CatchoomSDKError *)error {
    [self->activityIndicator stopAnimating];
    NSLog(@"Error: %@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No trobat..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self->videoPreviewView.hidden = NO;
    [_sdk unfreezeCapture];
}

@end

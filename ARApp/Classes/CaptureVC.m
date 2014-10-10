//
//  CaptureVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "CaptureVC.h"
#import <CatchoomSDK/CatchoomSDK.h>
#import <CatchoomSDK/CatchoomCloudRecognitionItem.h>

@interface CaptureVC () <CatchoomCloudRecognitionProtocol, CatchoomSDKProtocol, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIView *cameraView;

@end

CatchoomSDK *_sdk;
CatchoomCloudRecognition *_cloudRecognition;

@implementation CaptureVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup the Catchoom SDK
    _sdk = [CatchoomSDK sharedCatchoomSDK];
    [_sdk setDelegate:self];
    
    _cloudRecognition = [_sdk getCloudRecognitionInterface];
    [_cloudRecognition setDelegate:self];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    
    // Start Video Preview for search and tracking
    [_sdk startCaptureWithView: self.cameraView];
}

- (IBAction)scanButtonPressed:(UIButton *)sender {
    [_cloudRecognition singleShotSearch];
    [self.cameraView setHidden:YES];
    [sender setTitle:@"Scaning..." forState:UIControlStateNormal];
}

#pragma mark - CatchoomSDK Delegate

- (void) didStartCapture {
    // Get the CloudRecognition and set self as delegate to receive search responses
    [_cloudRecognition setToken:@"cbaf95971df4436c"];
}

#pragma mark - CatchoomCloudRecognition Delegate

- (void) didGetSearchResults:(NSArray *)resultItems {
    [self.scanButton setTitle:@"Scan" forState:UIControlStateNormal];
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
    [self.scanButton setTitle:@"Scan" forState:UIControlStateNormal];
    NSLog(@"Error: %@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No trobat..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

-(void)didValidateToken
{
    NSLog(@"Token validated");
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.cameraView setHidden:NO];
    [_sdk unfreezeCapture];
}


@end
